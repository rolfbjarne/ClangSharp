// Copyright (c) .NET Foundation and Contributors. All Rights Reserved. Licensed under the MIT License (MIT). See License.md in the repository root for more information.

using ClangSharp.Interop;
using static ClangSharp.Interop.CX_TypeClass;
using static ClangSharp.Interop.CXTypeKind;

namespace ClangSharp;

public sealed class ArrayParameterType : ConstantArrayType
{
    internal ArrayParameterType(CXType handle) : base(handle, CXType_ConstantArray, CX_TypeClass_ArrayParameter)
    {
    }
}
