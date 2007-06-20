From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 1/4] MMC-over-SPI header updates
Date: Wed, 20 Jun 2007 17:52:27 +0200
Message-ID: <46794D3B.1060009@drzeus.cx>
References: <200706101257.45278.david-b@pacbell.net>
	<200706131433.21238.david-b@pacbell.net>
	<4672D202.3000901@drzeus.cx>
	<200706161150.58273.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706161150.58273.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
> On Friday 15 June 2007, Pierre Ossman wrote:
>> Any CRC bugs should surface rather quickly, so that shouldn't be an isse.
> 
> Surfaced != fixed.  The issue is that resolving them isn't all that
> straightforward.  There's that one issue I surfaced, for example; it
> turns up some nasty recovery issues wholly unrelated to CRCs.
> 

I still think we should have the ambition that this can be made to work. We can
always remove it if that proves impossible (or not worth the effort).

> 
> If *you* want CRCs, then don't use the "use_crc=n" module option.
> The stack is usable without them; most hardware isn't glitchey
> enough to need them as more than a safety blanket.
> 

Silent data loss gives me the willies.

> Eventually, performance tuning should reduce that penalty, but
> until then the option is certainly in the "must have" category
> for at least developers.
> 

Fair enough.

>> From experience, I'd say it's likely that formats are reused. Looking at native
>> mode, we originally had R1, R1b, R2 and R3. Yet we are now able to support R4
>> through R7 using the components already defined.
> 
> You had to define new types, and update the code to use them.
> It was nice of the spec writers to make that easy for you, but
> you can't rely on that happening every time.
> 

You act like that happen by dumb luck. I'd say they looked at the existing spec
and designed the new features in a way that reused as much as possible. Sound
engineering really.

> 
> It seems like the new SDHC stuff has only one significant change
> affecting SPI:  there are now two requests which return a status
> byte plus four data bytes.  One uses the previously defined R3
> response type.  The other uses a newly defined R7 type.
> 
> So it seems like that particular issue can be addressed by morphing
> the current MMC_RSP_SPI_OCR code into an MMC_RSP_SPI_4BYTE type,
> along the lines of what you were talking about.
> 

My point exactly. I see no point in _OCR, but there is a possible gain with
_4BYTE (in the worst case, we get the same thing as if we'd done _OCR).

> 
> Mappings aren't lies though.  It's more like translation:  you
> can say something in French or in English, and get across the
> same core meaning.  To get certain details you'll want the
> original language ... but that doesn't mean the translation
> was a lie.
> 

You can't really compare computer protocols to human language. The level of
precision differs greatly.

Since you can't do a pure substitution, you have to simplify or try to guess
data. Both cases are accidents waiting to happen since the core is coded on the
assumption that the values reported are 100% correct.

> That said, I'd be glad to eventually see those R1 mappings
> begone, when the core stops needing them.
> 

So change the core.

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
