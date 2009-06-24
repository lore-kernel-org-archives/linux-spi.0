From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH] SST25L (non JEDEC) SPI Flash driver
Date: Thu, 25 Jun 2009 01:49:21 +0200
Message-ID: <63386a3d0906241649l60142ea2j1a608ce27c0f65cc@mail.gmail.com>
References: <4A3F017B.2010409@bluewatersys.com>
	 <63386a3d0906220122x31d0b23fk7bd86145b719d9b5@mail.gmail.com>
	 <4A3FFE02.8020001@bluewatersys.com>
	 <63386a3d0906230004m66360f4fhbdc80c8e552a01d0@mail.gmail.com>
	 <4A413F8F.6030500@bluewatersys.com>
	 <63386a3d0906241543n16da1f0gc988738f9efd8782@mail.gmail.com>
	 <4A42AD76.8040303@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Woodhouse <dwmw2@infradead.org>,
	linux-mtd@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net, mike@steroidmicros.com,
	linux kernel <linux-kernel@vger.kernel.org>,
	dedekind@infradead.org
To: Ryan Mallon <ryan@bluewatersys.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757303AbZFXXtd@vger.kernel.org>
In-Reply-To: <4A42AD76.8040303@bluewatersys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2009/6/25 Ryan Mallon <ryan@bluewatersys.com>:
> Linus Walleij wrote:
>> 2009/6/23 Ryan Mallon <ryan@bluewatersys.com>:
>>
>>> BTW, most of my other patches go via the ARM list, which uses the patch
>>> system. Whats the procedure for most other lists, do patches just get
>>> collected by the subsection maintainer when they are okay?
>>
>> That's the most typical procedure, however I think the SPI maintainer
>> (David) has been busy with other things so I merged the PL022
>> driver through the ARM tree instead. Another possibility is to send
>> it off to Andrew Mortons tree I guess.
>
> Can I get your acked-by and then just CC Andrew Morton?

I'm not much of a stakeholder in the SPI subsystem, but FWIW:
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
