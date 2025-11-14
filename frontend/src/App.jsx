import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Layout from './components/Layout';
import Home from './pages/Home';
import Categories from './pages/Categories';
import CategoryDetail from './pages/CategoryDetail';
import Study from './pages/Study';
import Flashcards from './pages/Flashcards';
import FlashcardForm from './pages/FlashcardForm';
import Progress from './pages/Progress';

function App() {
  return (
    <Router>
      <Layout>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/categories" element={<Categories />} />
          <Route path="/category/:slug" element={<CategoryDetail />} />
          <Route path="/study" element={<Study />} />
          <Route path="/study/:categoryId" element={<Study />} />
          <Route path="/flashcards" element={<Flashcards />} />
          <Route path="/flashcards/new" element={<FlashcardForm />} />
          <Route path="/flashcards/:id/edit" element={<FlashcardForm />} />
          <Route path="/progress" element={<Progress />} />
        </Routes>
      </Layout>
    </Router>
  );
}

export default App;
