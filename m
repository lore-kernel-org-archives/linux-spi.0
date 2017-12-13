From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH] spi: s3c64xx: add SPDX identifier
Date: Wed, 13 Dec 2017 10:48:54 +0900
Message-ID: <20171213014854.GG20051@gangnam.samsung>
References: <CGME20171212075830epcas2p31afc4a2e715e857694082748fd2bbe49@epcas2p3.samsung.com>
        <20171212075815.8683-1-andi.shyti@samsung.com>
        <CAJKOXPfdKyT8-bpM7tmveb3jWCRSSXwnkifhsRw_ag8X9z0W8A@mail.gmail.com>
        <20171212130313.GC1072@brancaleone.zhora.eu>
        <CAJKOXPc8o2_bMbXjwPopOtsoML0NqOzzHnYXCL9oU9VkU2cQYA@mail.gmail.com>
        <CAOFm3uHobATjskAKG83QoSQjXgzv1RQFv0vrgt_QgnZoxNQ2-w@mail.gmail.com>
        <CAJKOXPeZi=TWqoCo9x-Wa372ey8D=r8-Lf3CvJ95dgaMAF1kxQ@mail.gmail.com>
        <CAOFm3uEAzEgN-PgSOccbwO3aWfABsHywUmm8eXasR8CXy=NPJQ@mail.gmail.com>
        <CAJKOXPeCBPdCi2NnpBWimb4Py_zDZrsSK9o1cCswKM+XNeyqxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
        Andi Shyti <andi@etezian.org>, Kukjin Kim <kgene@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <CAJKOXPeCBPdCi2NnpBWimb4Py_zDZrsSK9o1cCswKM+XNeyqxQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Krzysztof,

> > Here, this should be as a top line:
> >
> > // SPDX-License-Identifier: GPL-2.0+
> >
> >
> > So I agree with the SPDX id but also pointing to the use of the C++ //
> > comment style as requested by Linus [1]
> 
> Thanks for the reference. I see that Linus prefers converting entire
> comment into // style. I was not arguing about SPDX line but entire
> existing copyright comment which follows it:
> 
> > +//
> > +// Copyright (c) 2009 Samsung Electronics Co., Ltd.
> > +//      Jaswinder Singh <jassi.brar@samsung.com>

it just looks ugly to me to have something like

  // SPDX...
  
  /*
   * Copyright (c)...
   *      Jasw...
   */

I would make everything of the '//' style (I've also seen that
this is the trend also in other subsystems), but honestly I don't
really care. If you're strong on not moving entirely in '//' style
then I can resend it with the double comment style.

Andi

P.S. About GPLv2 vs GPLv2+ I checked and I will repost it keeping
the license as its original. Thanks!
