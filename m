From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] spi: s3c64xx: add SPDX identifier
Date: Tue, 12 Dec 2017 14:45:12 +0100
Message-ID: <CAJKOXPc8o2_bMbXjwPopOtsoML0NqOzzHnYXCL9oU9VkU2cQYA@mail.gmail.com>
References: <CGME20171212075830epcas2p31afc4a2e715e857694082748fd2bbe49@epcas2p3.samsung.com>
 <20171212075815.8683-1-andi.shyti@samsung.com> <CAJKOXPfdKyT8-bpM7tmveb3jWCRSSXwnkifhsRw_ag8X9z0W8A@mail.gmail.com>
 <20171212130313.GC1072@brancaleone.zhora.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Andi Shyti <andi.shyti@samsung.com>, Kukjin Kim <kgene@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
To: Andi Shyti <andi@etezian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171212130313.GC1072@brancaleone.zhora.eu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 12, 2017 at 2:03 PM, Andi Shyti <andi@etezian.org> wrote:
> Hi Krzysztof,
>
>> > - * Copyright (C) 2009 Samsung Electronics Ltd.
>> > - *     Jaswinder Singh <jassi.brar@samsung.com>
>> > - *
>> > - * This program is free software; you can redistribute it and/or modify
>> > - * it under the terms of the GNU General Public License as published by
>> > - * the Free Software Foundation; either version 2 of the License, or
>> > - * (at your option) any later version.
>> > - *
>> > - * This program is distributed in the hope that it will be useful,
>> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > - * GNU General Public License for more details.
>> > - */
>> > +// SPDX-License-Identifier: GPL-2.0
>>
>
>> Existing license corresponds to GPL-2.0+, not GPL-2.0.
>
> mmmhhh... isn't it deprecated from 2.0rc2? Current SPDX version
> 2.6 doesn't have GPL-2.0+ in the list of licenses.
>
> https://spdx.org/licenses/
>
> I can improve the commit log to state it more clearly. Would that
> work?

No. The license identifier is deprecated, not the license itself.
Instead the, the SPDX says: <<This new syntax supports the ability to
use a simple “+” operator after a license short identifier to indicate
“or later version” (e.g. GPL-2.0+)>>. The spec [1] mentions it again:
"An SPDX License List Short Form Identifier with a unary"+" operator
suffix to represent the current version of the license or any later
version.  For example: GPL-2.0+"

Existing kernel sources follow this convention.

> BTW, is it really a change of license?

Yes, it is. Or maybe not license itself but it terms and specific
elements. GPL-2.0 does not say "any later option at your choice". Let
me quote:
"Each version is given a distinguishing version number. If the Program
specifies a version number of this License which applies to it and
"any later version", you have the option of following the terms and
conditions either of that version or of any later version published by
the Free Software Foundation. If the Program does not specify a
version number of this License, you may choose any version ever
published by the Free Software Foundation." [2]

What to add more here? GPL-2.0 only does not allow you to use any
later version ever published by FSF.

>
>> Why changing the comment style?
>
> That's SPDX, right? by adding the SPDX-License-Identifier the
> GPLv2 statement becomes redundant and we can remove some lines.

But it does not explain why existing comment has to be rewritten into //.

[1] https://spdx.org/spdx-specification-21-web-version
[2] https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html

Best regards,
Krzysztof
