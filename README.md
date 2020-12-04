# undo_redo_app
Memento pattern that used for undo and redo.  

## Technical
I am  using cursor index position to point the actual data.

|             |             |             |             |
| ----------- | ----------- |-------------|-------------|
| Data 1      | Data 2      |  Data 3     |Data 4       |
|             |             |             |    (*)      |

When doing undo:  
|             |             |             |             |
| ----------- | ----------- |-------------|-------------|
| Data 1      | Data 2      |  Data 3     |Data 4       |
|             |             |  (*)           |          |

Cursor will move down the index, and send data 3 to ui/view

When doing redo:
|             |             |             |             |
| ----------- | ----------- |-------------|-------------|
| Data 1      | Data 2      |  Data 3     |Data 4       |
|             |             |             |    (*)      |
Cursor will move up the index, and send data 4 to ui/view

When undo and inserting a new value:  
Process 1: undo... (for example, 2x undo)
|             |             |             |             |
| ----------- | ----------- |-------------|-------------|
| Data 1      | Data 2      |  Data 3     |Data 4       |
|             |     (*)     |             |          |

Process 2: user insering a new data: the datas that > cursor index will be removed and replaced by new data  
|             |             |             |
| ----------- | ----------- |-------------
| Data 1      | Data 2      | My new data|
|             |         |           (*)  |
