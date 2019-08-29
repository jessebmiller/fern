"""
PROTOTYPE: Emblem tool metacontent
"""
from sqlalchemy import create_engine
from pathlib import Path
from io import StringIO
import toml
import yaml
import json

class MultipleMetaFileError(Exception):
    pass


parsers = {
    ".toml": toml.load,
    ".yaml": yaml.safe_load,
    ".json": json.load,
}


class Metacontent:
    """
    metacontent walks the file tree from the root_path gathering metadata
    and associates that metadata with the content in the files

    """

    def __init__(self, root):
        root_path = Path(root)
        file_paths = (f for f in root_path.glob("**/*.*") if f.is_file())
        self.db = create_engine("sqlite://")

        # execute the migrations
        for statement in schema:
            self.db.execute(statement)

        # put each file path and it's metadata into the database
        # only for content files, no __meta__.* no hidden files
        for file_path in [f
                          for f
                          in file_paths
                          if f.stem != "__meta__"
                          and not f.stem.startswith('.')]:
            meta, content = self.__get_meta_and_content__(file_path, root_path)
            # TODO set up a view and instead of trigger to insert into
            self.db.execute(
                "insert into metadata (key, value) values (:key, :value)",
                [{"key": k, "value": v} for (k, v) in meta.items()],
            )
            self.db.execute(
                (
                    "insert into content (parent, stem, suffix, content) "
                    "values (:parent, :stem, :suffix, :content)"
                ),
                {
                    "parent": file_path.parent,
                    "stem": file_path.stem,
                    "suffix": file_path.suffix,
                    "content": content,
                },
            )
            self.db.execute(
                (# trying to insert the cross join from metadata to content
                    "insert into content_metadata (content_id, metadata_id) "
                    "select (content_id, metadata_id) from content "
                    " where 
        import pdb; pdb.set_trace()

    def __get_meta_and_content__(self, file_path, root_path):
        """
        __get_meta_and_content__ gathers the metadata and content
        from a pathlib.Path object

        """

        meta = {}
        path = root_path
        # in each parent folder starting with the root_path
        for part in file_path.parent.parts[len(root_path.parts):]:
            # combine the next part with the path (starting with root)
            path = Path(path, part)

            # look for meta files
            meta_file = [f for f in path.glob("__meta__.*")]
            if len(meta_file) > 1:
                raise MultipleMetaFileError(
                    f"Found {len(meta_file)} __meta__.* files in {path}",
                )
            elif len(meta_file) == 1:
                with meta_file[0].open() as f:
                    meta_data = parsers[meta_file[0].suffix](f)
                    meta.update(meta_data)

        with file_path.open() as f:
            first_line = f.readline()
            if not first_line.startswith("---"):
                # no front matter
                content = first_line + f.read()
            else: # there is front matter
                front_matter_lines = []
                line = f.readline()
                while not line.startswith("---"):
                    front_matter_lines.append(line)
                    line = f.readline()
                suffix = f".{first_line[3:-1]}"
                parser = parsers[suffix]
                stream = StringIO("".join(front_matter_lines))
                meta.update(parser(stream))
                content = f.read()

        return meta, content

    def search(self, **kwargs):
        results = self.db.execute(
            (
                "select stem "
                "  from content join content_metadata on content_id "
                "  join metadata on metadata_id "
                " where metadata.key = :key "
                "   and metadata.value = :value "
            ),
            [{"key": k, "value": v} for (k, v) in kwargs.items()],
        )
        return results

    def get(stem, meta={}):
        results = self.db.execute(
            (
                "select parent, stem, suffix"
                "  from content join content_metadata on content_id"
                "  join metadata on metadata_id"
                " where metadata.key = :key"
                "   and metadata.value = :value"
            ),
            [{"key": k, "value": v} for (k, v) in meta.items()],
        )
        return results

schema = [
    """
-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2019-08-17 14:34:30.559

-- tables
-- Table: content
CREATE TABLE content (
    id Integer NOT NULL CONSTRAINT content_pk PRIMARY KEY,
    parent text NOT NULL,
    stem text NOT NULL,
    suffix text
    content text
);
    """,
    """
-- Table: content_metadata
CREATE TABLE content_metadata (
    content_id Integer NOT NULL,
    metadata_id Integer NOT NULL,
    CONSTRAINT content_metadata_pk PRIMARY KEY (content_id,metadata_id),
    CONSTRAINT content_metadata_content FOREIGN KEY (content_id)
    REFERENCES content (id),
    CONSTRAINT content_metadata_metadata FOREIGN KEY (metadata_id)
    REFERENCES metadata (id)
);
    """,
    """
-- Table: metadata
CREATE TABLE metadata (
    id Integer NOT NULL CONSTRAINT metadata_pk PRIMARY KEY,
    "key" text NOT NULL,
    value text NOT NULL
);

-- End of file.
"""]
