From: Philippe Ombredanne <pombredanne-od1rfyK75/E@public.gmane.org>
Subject: Re: [PATCH] spi: s3c64xx: add SPDX identifier
Date: Tue, 12 Dec 2017 15:48:15 +0100
Message-ID: <CAOFm3uHobATjskAKG83QoSQjXgzv1RQFv0vrgt_QgnZoxNQ2-w@mail.gmail.com>
References: <CGME20171212075830epcas2p31afc4a2e715e857694082748fd2bbe49@epcas2p3.samsung.com>
 <20171212075815.8683-1-andi.shyti@samsung.com> <CAJKOXPfdKyT8-bpM7tmveb3jWCRSSXwnkifhsRw_ag8X9z0W8A@mail.gmail.com>
 <20171212130313.GC1072@brancaleone.zhora.eu> <CAJKOXPc8o2_bMbXjwPopOtsoML0NqOzzHnYXCL9oU9VkU2cQYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>, Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
        Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
To: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJKOXPc8o2_bMbXjwPopOtsoML0NqOzzHnYXCL9oU9VkU2cQYA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Dec 12, 2017 at 2:45 PM, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrot=
e:
> On Tue, Dec 12, 2017 at 2:03 PM, Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org> wrote:
>> Hi Krzysztof,
>>
>>> > - * Copyright (C) 2009 Samsung Electronics Ltd.
>>> > - *     Jaswinder Singh <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>> > - *
>>> > - * This program is free software; you can redistribute it and/or mod=
ify
>>> > - * it under the terms of the GNU General Public License as published=
 by
>>> > - * the Free Software Foundation; either version 2 of the License, or
>>> > - * (at your option) any later version.
>>> > - *
>>> > - * This program is distributed in the hope that it will be useful,
>>> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> > - * GNU General Public License for more details.
>>> > - */
>>> > +// SPDX-License-Identifier: GPL-2.0
>>>
>>
>>> Existing license corresponds to GPL-2.0+, not GPL-2.0.
>>
>> mmmhhh... isn't it deprecated from 2.0rc2? Current SPDX version
>> 2.6 doesn't have GPL-2.0+ in the list of licenses.
>>
>> https://spdx.org/licenses/
>>
>> I can improve the commit log to state it more clearly. Would that
>> work?
>
> No. The license identifier is deprecated, not the license itself.
> Instead the, the SPDX says: <<This new syntax supports the ability to
> use a simple =E2=80=9C+=E2=80=9D operator after a license short identifie=
r to indicate
> =E2=80=9Cor later version=E2=80=9D (e.g. GPL-2.0+)>>. The spec [1] mentio=
ns it again:
> "An SPDX License List Short Form Identifier with a unary"+" operator
> suffix to represent the current version of the license or any later
> version.  For example: GPL-2.0+"
>
> Existing kernel sources follow this convention.
>
>> BTW, is it really a change of license?
>
> Yes, it is. Or maybe not license itself but it terms and specific
> elements. GPL-2.0 does not say "any later option at your choice". Let
> me quote:
> "Each version is given a distinguishing version number. If the Program
> specifies a version number of this License which applies to it and
> "any later version", you have the option of following the terms and
> conditions either of that version or of any later version published by
> the Free Software Foundation. If the Program does not specify a
> version number of this License, you may choose any version ever
> published by the Free Software Foundation." [2]
>
> What to add more here? GPL-2.0 only does not allow you to use any
> later version ever published by FSF.
>
>>
>>> Why changing the comment style?
>>
>> That's SPDX, right? by adding the SPDX-License-Identifier the
>> GPLv2 statement becomes redundant and we can remove some lines.
>
> But it does not explain why existing comment has to be rewritten into //.
>
> [1] https://spdx.org/spdx-specification-21-web-version
> [2] https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html
>
> Best regards,
> Krzysztof

IMHO you should refer to Thomas doc patches instead of looking for
details elsewhere [1]
They are the authoritative doc for the kernel.

CC: Greg Kroah-Hartman
CC: Thomas Gleixner

[1] https://lkml.org/lkml/2017/12/4/934
--=20
Cordially
Philippe Ombredanne
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
