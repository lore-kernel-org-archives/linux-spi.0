From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH] SST25L (non JEDEC) SPI Flash driver
Date: Wed, 24 Jun 2009 08:48:15 +1200
Message-ID: <4A413F8F.6030500@bluewatersys.com>
References: <4A3F017B.2010409@bluewatersys.com>	 <63386a3d0906220122x31d0b23fk7bd86145b719d9b5@mail.gmail.com>	 <4A3FFE02.8020001@bluewatersys.com> <63386a3d0906230004m66360f4fhbdc80c8e552a01d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Woodhouse <dwmw2@infradead.org>,
	linux-mtd@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net, mike@steroidmicros.com,
	linux kernel <linux-kernel@vger.kernel.org>,
	dedekind@infradead.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751955AbZFWUqa@vger.kernel.org>
In-Reply-To: <63386a3d0906230004m66360f4fhbdc80c8e552a01d0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Linus Walleij wrote:
> 2009/6/22 Ryan Mallon <ryan@bluewatersys.com>:
> 
>> Out of curiosity: I'm not too clear on what makes a particular chip
>> hot-pluggable. I think technically the sst25l chip could be put onto a
>> hot-pluggable board or power domain. Can't most devices be made
>> hot-pluggable? Is the general rule to make devices non hot-pluggable if
>> most/all boards in the mainline do not allow it to be hot-plugged?
> 
> I haven't seen any rule about it, but nominally the drivers support the
> configurations found in the kernel tree, so if some board physically
> existing and soon-to-run linux hotplugs chips like this, then have it
> __dev{init|exit} else __{init|exit} IMHO.
> 
> Of course you can design for all plausible use cases but it will pile up
> indefinitely. Personally I try to not design software for a hardware until it
> exists, and I like the IETF catch-phrase "rough consensus and running
> code" and this sort of fits that :-)

Okay, thanks. Thats basically the conclusion we came to as well: if
someone else wants to hotplug this chip in the future they can post a
patch for it.

BTW, most of my other patches go via the ARM list, which uses the patch
system. Whats the procedure for most other lists, do patches just get
collected by the subsection maintainer when they are okay?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

       Ryan Mallon                              Unit 5, Amuri Park
       Phone: +64 3 3779127                     404 Barbadoes St
       Fax:   +64 3 3779135                     PO Box 13 889
       Email: ryan@bluewatersys.com             Christchurch, 8013
       Web:   http://www.bluewatersys.com       New Zealand
       Freecall Australia  1800 148 751         USA 1800 261 2934
