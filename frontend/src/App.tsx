import { useQuery } from '@tanstack/react-query';
import ploneClient from '@plone/client';

const client = ploneClient.initialize({
  apiPath: 'http://localhost:8000',
});

function App() {
  const { getContentQuery } = client;
  const { data: content, isLoading } = useQuery(getContentQuery({ path: '/' }));

  return (
    <div>
      {isLoading ? (
        <p>Loading...</p>
      ) : (
        content && (
          <article>
            <h2>{content.title}</h2>
            {content.description && <p>{content.description}</p>}
            {(content as any).text && (
              <div
                dangerouslySetInnerHTML={{ __html: (content as any).text.data }}
              />
            )}
          </article>
        )
      )}
    </div>
  );
}

export default App;










