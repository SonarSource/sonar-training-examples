import Link from 'next/link'
import styles from '@/styles/shared.module.css'
import {FormEventHandler, useRef, useState} from "react";

export default function Home() {
  const inputRef = useRef<HTMLInputElement>(null);
  const [testedFrom, setTestedFrom] = useState('');

  const handleSubmit: FormEventHandler<HTMLFormElement> = (ev) => {
    ev.preventDefault();
    if (inputRef.current!.value === 'from-jest') {
      setTestedFrom('Tested by jest');
    } else if (inputRef.current!.value === 'from-cypress') {
      setTestedFrom('Tested by cypress');
    } else {
      setTestedFrom('Not tested');
    }
  }

  return (
    <div className={styles.container}>
      <main className={styles.main}>
        <form data-testid="testing-form" onSubmit={handleSubmit}>
          <input ref={inputRef} data-testid="testing-input" placeholder="test me" />
          <button data-testid="testing-button">Submit</button>
          <p data-testid="testing-p">{testedFrom}</p>
        </form>
        <h1>Home Page</h1>
        <p className={styles.description}>
          <Link href="/about">Go To The About Page &rarr;</Link>
        </p>
      </main>
    </div>
  )
}
