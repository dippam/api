Dippam::Application.routes.draw do
  resources :summary_documents, :vmr_tracks, :vmr_interviews,
            :eppi_lc_subjects, :ied_institutions
  resources :eppi_documents do
    resources :eppi_pages do
      get :download, on: :member
    end
  end
  resources :ied_records do 
    resources :ied_pages, :enclosures
  end
end
