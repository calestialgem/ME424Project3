classdef printer
properties
	file
end
methods
function self = printer(file_name)
	[file, error_message] = fopen(file_name, 'w');
	if ~isempty(error_message)
		fprintf(2, "File %s Error Message: %s\n", file_name, error_message);
		return;
	end
	self.file = file;
end
function close(self)
	if fclose(self.file) ~= 0
		fprintf(2, "Error while closing the file\n");
		return;
	end
	self.file = [];
end
function print(self, varargin)
	message = sprintf(varargin{:});
	fprintf(self.file, '%s\n', message);
	fprintf('%s\n', message);
end
end
end
