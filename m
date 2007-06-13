From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 1/4] MMC-over-SPI header updates
Date: Wed, 13 Jun 2007 14:33:20 -0700
Message-ID: <200706131433.21238.david-b@pacbell.net>
References: <200706101257.45278.david-b@pacbell.net>
	<200706121106.42067.david-b@pacbell.net>
	<466FAA0C.9020102@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
To: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <466FAA0C.9020102-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Content-Disposition: inline
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

On Wednesday 13 June 2007, Pierre Ossman wrote:
> David Brownell wrote:
> > 
> > The point is that this way we can keep the host driver out of the business
> > of deciding whether or not to enable CRC mode.  The main alternative would
> > be to move that module parameter into the MMC core.
> 
> Why would we want to turn it off?

It starts "off", and needs to be turned "on".  Reasons to leave it
off include performance (I measured over 30% slower with CRCs on while
writing a 120+ MB SD partition), and of course the fact that the CRC
stuff is the very newest feature in the code (thanks Jan!), and is not
yet as trustworthy (viz. the intermittent bug I noted).


> > This directly matches every MMC spec I've seen ... they define the response
> > format in those terms.  And I made this change per your request ... the host
> > driver checks for "R1", "R2", etc which are built up from those components.
> > 
> 
> The components we defined for native mode cannot be found in the specs, we
> derived them from the descriptions. So the same thing goes for SPI.

Umm ... no, not really; did you cross-check with the SPI specs?  All
the requests return one status byte.  One returns a second one.  One
returns the OCR in the place that second byte would be.  Some leave
the chip in a "busy" state.  Those are the components out of which
the SPI_R1, SPI_R1B, SPI_R2, and SPI_R3 are built.  (R3 is the one
which includes OCR.)


> The point of this exercise is that we do not have to modify host drivers when
> new response types show up (which it has when MMC got extended to SD, and SD to
> SDIO).

That seems like a fantasy to me.  We don't know in advance how those
types will be defined (or if they even will be!), so there's no way
we can know whether or not new types will need to be defined.

In fact it's almost certain that we *would* have to change that low
level protocol code to understand additional response types.  The
handling for them has to be hand coded in all cases...


> So when R666 shows up, which happens to contain the anti-christ and be 5 bytes
> long, we can describe this using existing defines and not have to modify the
> host drivers. Having a name like "OCR" then does not describe properly what we
> want the host to do.

Leaving the semantic question of where those 5 bytes would need to be
stored.  Clearly since it was defined as a new response type, the answer
used for R3 would not be appropriate... and R3 is the only 5 byte response
currently defined.


> > I'll note that the "native" bits include meaning too ... opcode is most
> > certainly meaning, as is CRC.
> > 
> 
> Granted, this is a bit fuzzy in some areas. These two are sometimes not reported
> by hw, we can only tell it to check that they are correct. And there is no real
> variation what we want to do with these values. Compare that to the payload
> where it is difficult, if not impossible, for the host driver to determine what
> we want to do with it.

You're missing the point that those values you're objecting to are fully
defined as part of the protocol, so we *DO* know exactly what to do ...

 
> Just trust me on this, we do _not_ want semantics in the host drivers. It has
> caused problems with at least three host drivers so far, and omap is still
> unable to use SD cards because it tries to parse responses by itself.

This isn't the OMAP driver though.  And I can't exactly make sense of the
guts of your objection (see next).

 
> The rule of thumb is, data the core wants back should not be parsed by the host
> driver. Things the core just wants validated is ok to parse in the host driver.

That's a fine policy.  (Though I've observed that most policies driving
interface design need to be broken sometimes.)

You've objected surprisingly vociferously ... given that so far as I
understand what you mean, that's the exact rule now followed in the
mmc_spi host driver!

 
> > 
> > OK, I can remove that stuff now that the raw SPI status bytes are being
> > returned in resp[] ... I'll have to update the spi_mmc driver though,
> > and I'll hold off on that for a bit since I expect you'll send comments
> > specifically on that driver.
> > 
> 
> Great. I'll ignore the mapping parts in there for now then and review the rest
> of the code.

Well, the R1_STATE bits of the mapping.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
