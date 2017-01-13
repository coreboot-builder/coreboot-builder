RSpec.describe BuildsController type: :controller do
  describe 'start' do
    it 'renders start'
    it 'is successfull'
  end

  describe 'index' do
    context 'without email' do
      it 'redirects to new build path'
      it 'flashes an error'
    end
    context 'with email' do
      it 'renders index'
      it 'is successfull'
    end
  end

  describe 'new' do
    it 'renders new'
    it 'is successfull'
  end

  describe 'create' do
    context 'with valid build params' do
      it 'redirect to choose device'
      it 'creates a new build'
    end
    context 'with invalid build params' do
      it 'does not create a new build'
      it 'renders new'
      it 'flashes an error'
    end
  end
end
