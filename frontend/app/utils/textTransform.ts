import { startCase } from 'lodash'

export const transformTextToSentence = (text: string) =>
  startCase(text.replace(/_/g, ' '))
