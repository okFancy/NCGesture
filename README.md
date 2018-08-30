# NCGesture

you can simply use blocks with methods like onTap. Each UIView object includes those methods via special extension

### Usage

```
let view = UIView()

/*
 * Add tap gesture recognizer without configuration block to view.
 */

view.onTap { (tapGestureRecognizer) in
    // Handle tap on view
    tapGestureRecognizer.view!.backgroundColor = .green
}

/*
 * Add tap gesture recognizer with configuration block to view.
 */

view.onTap(when: .always, handle: { (tapGestureRecognizer) in
    // Handle tap on view
    tapGestureRecognizer.view!.backgroundColor = .green
}) { (tapGestureRecognizer) in
    // Configure gesture recognizer
    tapGestureRecognizer.numberOfTouchesRequired = 1
    tapGestureRecognizer.numberOfTapsRequired = 2
}

/*
 * Add one-time tap gesture recognizer with configuration block to view.
 * Gesture recognizer will be removed from view after first recognition.
 */

view.onTap(when: .once, handle: { (tapGestureRecognizer) in
    // Handle tap on view
    tapGestureRecognizer.view!.backgroundColor = .green
}) { (tapGestureRecognizer) in
    // Configure gesture recognizer
    tapGestureRecognizer.numberOfTouchesRequired = 1
    tapGestureRecognizer.numberOfTapsRequired = 2
}

/*
 * Set number of times to handle tap gesture in view.
 * Gesture recognizer will be removed from view after 10 recognitions.
 */

view.onTap(when: .times(count: 10), handle: { (tapGestureRecognizer) in
    // Handle tap on view
    tapGestureRecognizer.view!.backgroundColor = .green
}) { (tapGestureRecognizer) in
    // Configure gesture recognizer
    tapGestureRecognizer.numberOfTouchesRequired = 1
    tapGestureRecognizer.numberOfTapsRequired = 2
}
```

```

And this is how you should use TapGestureRecognizer:

let tapGestureRecognizer = TapGestureRecognizer { (tapGestureRecognizer) in
    // Do something...
}

```

## 中文
一个 block 形式手势识别器
