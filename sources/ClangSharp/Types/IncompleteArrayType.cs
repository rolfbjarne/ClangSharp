// Copyright (c) .NET Foundation and Contributors. All Rights Reserved. Licensed under the MIT License (MIT). See License.md in the repository root for more information.

using ClangSharp.Interop;
using static ClangSharp.Interop.CX_TypeClass;
using static ClangSharp.Interop.CXTypeKind;

namespace ClangSharp;

public sealed class IncompleteArrayType : ArrayType
{
    internal IncompleteArrayType(CXType handle) : base(handle, CXType_IncompleteArray, CX_TypeClass_IncompleteArray)
    {
    }
}
