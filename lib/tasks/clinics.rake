task 'clinics:fetch' => 'environment' do
  ClinicFetcherJob.perform_now
end
