From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v2] spi: s3c64xx: add SPDX identifier
Date: Thu, 14 Dec 2017 07:16:17 +0100
Message-ID: <CAOFm3uHjACc9W-k7prAwis1o07AGJSG1DUvOQi5KgjWYCs6MVw@mail.gmail.com>
References: <CGME20171213080544epcas2p29731b6c65f760ab1b9ac71d530fcaf77@epcas2p2.samsung.com>
 <20171213080530.12724-1-andi.shyti@samsung.com> <CAOFm3uHP-4UN+gzXzZc1ptptFm5f9uhafKyE963+DiamzdRTdw@mail.gmail.com>
 <20171214013109.GC11657@gangnam.samsung>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Shyti <andi@etezian.org>
To: Andi Shyti <andi.shyti@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20171214013109.GC11657@gangnam.samsung>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Andi,

On Thu, Dec 14, 2017 at 2:31 AM, Andi Shyti <andi.shyti@samsung.com> wrote:
> Hi Philippe,
>
>> > diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
>> > index da79774078a7..8917f38c97c5 100644
>> > --- a/include/linux/platform_data/spi-s3c64xx.h
>> > +++ b/include/linux/platform_data/spi-s3c64xx.h
>> > @@ -2,9 +2,7 @@
>> >   * Copyright (C) 2009 Samsung Electronics Ltd.
>> >   *     Jaswinder Singh <jassi.brar@samsung.com>
>> >   *
>> > - * This program is free software; you can redistribute it and/or modify
>> > - * it under the terms of the GNU General Public License version 2 as
>> > - * published by the Free Software Foundation.
>> > + * SPDX-License-Identifier: GPL-2.0
>> >   */
>> >
>> >  #ifndef __SPI_S3C64XX_H
>> > --
>> > 2.15.1
>> >
>>
>>
>> You still need to put this line at the very top of the file, first
>> line. That's the convention for the SPDX tags as documented by Thomas
>> Gleixner.
>
> I had some doubts on this one, indeed. How should it be done in
> this case:
>
> 1. Strictly by Thomas documentation:
>
>   /* SPDX-License-Identifier: GPL-2.0 */
>
>   /*
>    * Copyright (C) 2009 Samsung Electronics Ltd.
>    *     Jaswinder Singh <jassi.brar@samsung.com>
>    */
>
> or
>
> 2. with a little interpretation
>
>   /*
>    * SPDX-License-Identifier: GPL-2.0
>    *
>    * Copyright (C) 2009 Samsung Electronics Ltd.
>    *     Jaswinder Singh <jassi.brar@samsung.com>
>    */
>
> (I opted for the one with the least number of changes)

You should go strictly by Thomas' doc. This is one area where
consistency is the thing that brings benefits. Interpretation is not
needed.
So please, consider going with 1.
-- 
Cordially
Philippe Ombredanne
