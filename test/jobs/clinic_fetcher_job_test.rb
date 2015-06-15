require 'test_helper'

class ClinicFetcherJobTest < ActiveJob::TestCase
  let(:job) { ClinicFetcherJob.new }
  let(:file) { job.send(:fda_zip_file) }

  describe :fda_zip_file do
    it "returns a tempfile" do
      assert(file.is_a?(Tempfile), "`fda_zip_file` did not return a Tempfile")
    end

    it "is not an empty file" do
      assert(file.size > 0, "`fda_zip_file` was empty")
    end

    it "contains a public.txt file" do
      assert(Zip::File.new(file).find_entry("public.txt"), "`fda_zip_file` returned a file without a `public.txt` file")
    end
  end

  describe :extract_csv do
    it "returns an IO object" do
      assert(job.send(:extract_csv, file).respond_to? :read)
    end
  end

  describe :parse_csv do
    let(:parsed_csv) { job.send(:parse_csv, job.send(:extract_csv, file)) }

    it "returns an array of hashes" do
      assert_kind_of(Array, parsed_csv)
      assert_kind_of(Hash, parsed_csv[0])
    end
  end

end
