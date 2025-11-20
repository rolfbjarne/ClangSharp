// Copyright (c) .NET Foundation and Contributors. All Rights Reserved. Licensed under the MIT License (MIT). See License.md in the repository root for more information.

// Ported from https://github.com/llvm/llvm-project/tree/llvmorg-20.1.2/clang/include/clang-c
// Original source is Copyright (c) the LLVM Project and Contributors. Licensed under the Apache License v2.0 with LLVM Exceptions. See NOTICE.txt in the project root for license information.

using System;

namespace ClangSharp.Interop;

public struct VersionTuple : IEquatable<VersionTuple>{
    public static readonly VersionTuple Empty;

    private readonly /* NOPE; NOT READONLY */ uint major;
    private readonly /* NOPE; NOT READONLY */ uint minor;
    private readonly /* NOPE; NOT READONLY */ uint subminor;
    private readonly /* NOPE; NOT READONLY */ uint build;

    private const int HasFlag = 0;
    private const int HasShift = 1;

    public uint Major => major;

    public uint? Minor {
        get {
            if (HasMinor) {
                return minor >> HasShift;
            }
            return null;
        }
    }

    public uint? Subminor {
        get {
            if (HasSubminor) {
                return subminor >> HasShift;
            }
            return null;
        }
    }

    public uint? Build {
        get {
            if (HasBuild) {
                return build >> HasShift;
            }
            return null;
        }
    }

    private uint MinorOrZero {
        get {
            if (HasMinor) {
                return minor >> HasShift;
            }
            return 0;
        }
    }

    private uint SubminorOrZero {
        get {
            if (HasSubminor) {
                return subminor >> HasShift;
            }
            return 0;
        }
    }

    private uint BuildOrZero {
        get {
            if (HasBuild) {
                return build >> HasShift;
            }
            return 0;
        }
    }

    public bool HasMinor => (minor & HasFlag) == HasFlag;
    public bool HasSubminor => (subminor & HasFlag) == HasFlag;
    public bool HasBuild => (build & HasFlag) == HasFlag;

    public bool IsEmpty => major == 0 && minor == 0 && subminor == 0 && build == 0;

    public static bool operator == (VersionTuple x, VersionTuple y)
    {
        return x.Major == y.Major &&
            x.MinorOrZero == y.MinorOrZero &&
            x.SubminorOrZero == y.SubminorOrZero &&
            x.BuildOrZero == y.BuildOrZero;
    }

    public static bool operator != (VersionTuple x, VersionTuple y)
        => !(x == y);

    public static bool operator < (VersionTuple x, VersionTuple y)
    {
        if (x.Major != y.Major) {
            return x.Major < y.Major;
        }
        if (x.MinorOrZero != y.MinorOrZero) {
            return x.MinorOrZero < y.MinorOrZero;
        }
        if (x.SubminorOrZero != y.SubminorOrZero) {
            return x.MinorOrZero < y.MinorOrZero;
        }
        if (x.BuildOrZero != y.BuildOrZero) {
            return x.BuildOrZero < y.BuildOrZero;
        }
        return false;
    }

    public static bool operator > (VersionTuple x, VersionTuple y)
    {
        if (x.Major != y.Major) {
            return x.Major > y.Major;
        }
        if (x.MinorOrZero != y.MinorOrZero) {
            return x.MinorOrZero > y.MinorOrZero;
        }
        if (x.SubminorOrZero != y.SubminorOrZero) {
            return x.MinorOrZero > y.MinorOrZero;
        }
        if (x.BuildOrZero != y.BuildOrZero) {
            return x.BuildOrZero > y.BuildOrZero;
        }
        return false;
    }

    public static bool operator <= (VersionTuple x, VersionTuple y)
        => x == y || x < y;

    public static bool operator >= (VersionTuple x, VersionTuple y)
        => x == y || x > y;

    public override bool Equals(object? obj)
    {
        if (obj is VersionTuple vt) {
            return vt == this;
        }
        return false;
    }

    bool IEquatable<VersionTuple>.Equals (VersionTuple version)
    {
        return this == version;
    }

    public override int GetHashCode ()
    {
        return HashCode.Combine (major, minor, subminor, build);
    }
}
