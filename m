From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 1/4] MMC-over-SPI header updates
Date: Fri, 15 Jun 2007 19:53:06 +0200
Message-ID: <4672D202.3000901@drzeus.cx>
References: <200706101257.45278.david-b@pacbell.net>
	<200706121106.42067.david-b@pacbell.net>
	<466FAA0C.9020102@drzeus.cx>
	<200706131433.21238.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706131433.21238.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
> It starts "off", and needs to be turned "on".  Reasons to leave it
> off include performance (I measured over 30% slower with CRCs on while
> writing a 120+ MB SD partition), and of course the fact that the CRC
> stuff is the very newest feature in the code (thanks Jan!), and is not
> yet as trustworthy (viz. the intermittent bug I noted).
> 

Any CRC bugs should surface rather quickly, so that shouldn't be an isse.
Performance might be though, but do people really feel that those 30% is worth
losing CRC? I sure wouldn't feel comfortable with that.

> 
> Umm ... no, not really; did you cross-check with the SPI specs?  All
> the requests return one status byte.  One returns a second one.  One
> returns the OCR in the place that second byte would be.  Some leave
> the chip in a "busy" state.  Those are the components out of which
> the SPI_R1, SPI_R1B, SPI_R2, and SPI_R3 are built.  (R3 is the one
> which includes OCR.)
> 

But the controller will be fine just knowing "one byte", "two bytes" and "five
bytes" respectively.

> 
> That seems like a fantasy to me.  We don't know in advance how those
> types will be defined (or if they even will be!), so there's no way
> we can know whether or not new types will need to be defined.
> 
> In fact it's almost certain that we *would* have to change that low
> level protocol code to understand additional response types.  The
> handling for them has to be hand coded in all cases...
> 

>From experience, I'd say it's likely that formats are reused. Looking at native
mode, we originally had R1, R1b, R2 and R3. Yet we are now able to support R4
through R7 using the components already defined.

> 
> Leaving the semantic question of where those 5 bytes would need to be
> stored.  Clearly since it was defined as a new response type, the answer
> used for R3 would not be appropriate... and R3 is the only 5 byte response
> currently defined.
> 

Why not? It's not like we store R1 and R2 differently except for their size.

> 
> You're missing the point that those values you're objecting to are fully
> defined as part of the protocol, so we *DO* know exactly what to do ...
> 

My point is that we're spreading that knowledge into too many areas. Keep it in
the core and let the host driver deal with shuffling bits.

> 
> Well, the R1_STATE bits of the mapping.
> 

All mappings. The host driver shouldn't lie to the core.

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
