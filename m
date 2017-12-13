From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] spi: s3c64xx: add SPDX identifier
Date: Wed, 13 Dec 2017 08:23:47 +0100
Message-ID: <CAJKOXPevhP41cU67AgZhW1Hh319ifPi4EAEVXp5yLcOi61n-1g@mail.gmail.com>
References: <CGME20171212075830epcas2p31afc4a2e715e857694082748fd2bbe49@epcas2p3.samsung.com>
 <20171212075815.8683-1-andi.shyti@samsung.com> <CAJKOXPfdKyT8-bpM7tmveb3jWCRSSXwnkifhsRw_ag8X9z0W8A@mail.gmail.com>
 <20171212130313.GC1072@brancaleone.zhora.eu> <CAJKOXPc8o2_bMbXjwPopOtsoML0NqOzzHnYXCL9oU9VkU2cQYA@mail.gmail.com>
 <CAOFm3uHobATjskAKG83QoSQjXgzv1RQFv0vrgt_QgnZoxNQ2-w@mail.gmail.com>
 <CAJKOXPeZi=TWqoCo9x-Wa372ey8D=r8-Lf3CvJ95dgaMAF1kxQ@mail.gmail.com>
 <CAOFm3uEAzEgN-PgSOccbwO3aWfABsHywUmm8eXasR8CXy=NPJQ@mail.gmail.com>
 <CAJKOXPeCBPdCi2NnpBWimb4Py_zDZrsSK9o1cCswKM+XNeyqxQ@mail.gmail.com> <20171213014854.GG20051@gangnam.samsung>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
        Andi Shyti <andi@etezian.org>, Kukjin Kim <kgene@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: Andi Shyti <andi.shyti@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20171213014854.GG20051@gangnam.samsung>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Dec 13, 2017 at 2:48 AM, Andi Shyti <andi.shyti@samsung.com> wrote:
> Hi Krzysztof,
>
>> > Here, this should be as a top line:
>> >
>> > // SPDX-License-Identifier: GPL-2.0+
>> >
>> >
>> > So I agree with the SPDX id but also pointing to the use of the C++ //
>> > comment style as requested by Linus [1]
>>
>> Thanks for the reference. I see that Linus prefers converting entire
>> comment into // style. I was not arguing about SPDX line but entire
>> existing copyright comment which follows it:
>>
>> > +//
>> > +// Copyright (c) 2009 Samsung Electronics Co., Ltd.
>> > +//      Jaswinder Singh <jassi.brar@samsung.com>
>
> it just looks ugly to me to have something like
>
>   // SPDX...
>
>   /*
>    * Copyright (c)...
>    *      Jasw...
>    */
>
> I would make everything of the '//' style (I've also seen that
> this is the trend also in other subsystems), but honestly I don't
> really care. If you're strong on not moving entirely in '//' style
> then I can resend it with the double comment style.

Let's follow Linus' preference - entire commend converted as you did already.

Thanks,
Krzysztof
