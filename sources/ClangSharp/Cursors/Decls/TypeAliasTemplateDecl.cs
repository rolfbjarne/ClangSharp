// Copyright (c) .NET Foundation and Contributors. All Rights Reserved. Licensed under the MIT License (MIT). See License.md in the repository root for more information.

using ClangSharp.Interop;
using static ClangSharp.Interop.CX_DeclKind;
using static ClangSharp.Interop.CXCursorKind;

namespace ClangSharp;

public sealed class TypeAliasTemplateDecl : RedeclarableTemplateDecl
{
    internal TypeAliasTemplateDecl(CXCursor handle) : base(handle, CXCursor_TypeAliasTemplateDecl, CX_DeclKind_TypeAliasTemplate)
    {
    }
}
