From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: PATCH[V2 1/3]: Update Platform files for SPI
Date: Tue, 9 Feb 2010 17:10:21 -0700
Message-ID: <fa686aa41002091610y59d55626nf783fa2f5b8171e9@mail.gmail.com>
References: <9629.10.24.255.17.1265192505.squirrel@dbdmail.itg.ti.com>
	<20100209222513.GJ21755@atomide.com> <fa686aa41002091440p588ad328i14d0fb28390b2672@mail.gmail.com>
	<20100209230710.GL21755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hemanth V <hemanthv@ti.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-omap@vger.kernel.org, dbrownell@users.sourceforge.net
To: Tony Lindgren <tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20100209230710.GL21755@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 9, 2010 at 4:07 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Grant Likely <grant.likely@secretlab.ca> [100209 14:38]:
>> On Tue, Feb 9, 2010 at 3:25 PM, Tony Lindgren <tony@atomide.com> wro=
te:
>> > * Hemanth V <hemanthv@ti.com> [100203 02:19]:
>> >> From ee48142ddc43129a21676dbb56a83e3e7d8063de Mon Sep 17 00:00:00=
 2001
>> >> From: Hemanth V <hemanthv@ti.com>
>> >> Date: Fri, 27 Nov 2009 14:22:30 +0530
>> >> Subject: [PATCH] Update platform files
>> >>
>> >> This patch updates platform files for
>> >> fifo, slave support
>> >>
>> >> Signed-off-by: Hemanth V <hemanthv@ti.com>
>> >
>> > This should get merged via the spi-devel list with the other patch=
es.
>> >
>> > Acked-by: Tony Lindgren <tony@atomide.com>
>>
>> Personally, I prefer not to carry arch/* changes in my next-spi
>> branch, since it means that my pull requests are less obvious for
>> Linus and there is greater chance of conflict.
>>
>> But if you still really want me to merge it through my tree, (or if
>> getting the patches out of order will break things) then I'll pick i=
t
>> up. =A0Just let me know.
>
> OK, if you ack it, I'll add the header into omap for-next. That
> might break git bisect for some configurations depending in which
> order the patches get pulled by Linus..

git bisect breakage is breakage enough.  :-)  You're right.  I should
pick this one up.  I can see that now that I've had my tea and I'm no
longer grumpy.

> I guess eventually this header should not live under plat.

Any reason the header cannot be moved to include/linux/spi/ now?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
