From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 4/4] MMC-over-SPI host driver
Date: Wed, 20 Jun 2007 18:20:48 +0200
Message-ID: <467953E0.8050408@drzeus.cx>
References: <200706101257.45278.david-b@pacbell.net>
	<200706132105.51711.david-b@pacbell.net>
	<4672D9C5.9080707@drzeus.cx>
	<200706171329.12709.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706171329.12709.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

David Brownell wrote:
> 
> If the MMC core and block code change more, many can go.  Remember
> that I was making such core changes in small, safe doses!
> 
> Right now it looks like the main reason to keep including mmc.h is
> to handle one aspect of mapping the data error token.  Four of its
> bits are part of normal R2 response, suitable for shift-and-mask
> handling, but the 0x10 bit seems to be vendor specific ... so for
> now, if that's set I map it to R2_SPI_ERROR (generic "it broke")
> and use that symbol to avoid excess magic numbers.
> 

Don't map at all. Just give the core what you got from the card.

> 
>> 	 I suggest another feel
>> to the ios structure. And drop the CAP_CRC, we'll consider CRC support mandatory
>> (even though you can have the option of turning it off in runtime).
> 
> That's not a complete description.  :)
> You're thinking of something like this?
> 
>  - always do the (dirt cheap) crc7 in the command;
>  - move the module parameter into mmc core, default spi_crc=y;
>  - add mmc_ios.spi_crc, initialized to match the module parameter;
>  - mmc_spi_set_crc() uses that parameter; and
>  - mmc_spi host will use that instead of its current use_crc, to
>    tell whether it should init or verify datablock CRC16 values.
> 

Yes. It more clearly separates mechanism (the host driver) from policy (the mmc
core).

> Except this doesn't seem like an ios-style thing to me... that's
> on top of me disliking that confusing and error-prone "check N
> parameters to see which ones should change this time" API style.
> 

I'm no fan of this ios thing either, but it's what we've got and it hasn't been
worth the effort to rewrite it yet.

> Having a simple flag in mmc_host would be much better.

Perhaps. But there's a lot of value in consistency.

> 
> I'll leave a #define pending a better solution though.
> Maybe MMC_ERRNO_BADCRC not ECRC?
> 

Well, since we're scrapping those custom error codes, then that's probably not a
good idea. We can hold off on this issue until that mess is sorted out.

> 
> After changing the existing usage of that code, and assuming
> that code becomes reserved for that role within the MMC stack...
> 

Overloading use of errno:s is rather common. Just look at ETIMEDOUT.

> 
> It *IS* already encoded in the request:  only multiblock writes
> need to use that token.  Likewise they use special start tokens
> for each block.  And in the same way, other data blocks use a
> third kind of start token; and may have data-dependent CRC values.
> All such values are managed below the core.
> 
> This is just something that a person adding SET_BLOCK_COUNT
> support (CMD23, for MMC only) would need to worry about.  And
> that command seems to be "reserved" in more documents than not,
> so it's unlikely to ever matter.  I updated that comment.
> 

Well, that person shouldn't have to worry about it as the host driver should
service all valid requests.

>>>> Sounds like this signaling can be done with the chip select ios already present
>>>> in the mmc layer. Then we won't need voodoo in the host driver.
>>> No.
>>>
>> Why not? It would allow us to keep higher protocol semantics (which varying
>> delays depending on opcodes is after all) in the core.
> 
> Well for starters, it's packaged in the mmc_ios which holds things that
> don't change between requests, but SPI chipselect always goes active at
> the beginning of every request and then goes inactive when it's done.
> 

Who said mmc_ios doesn't change between requests? And as your code states, it
isn't as simple as keeping it on during just the request.

> It seems the only reason to have it in mmc_ios is to help work around
> some wbsd quirks during card enumeration.  Other controllers manage to
> keep that signal pulled up until entering 4-wire mode.
> 

We try to think a bit more general than that, even though it was first
implemented because the wbsd driver needed it.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
