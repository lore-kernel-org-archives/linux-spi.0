From: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>
Subject: Re: [patch 4/4 2.6.23-rc2 + mm2-git-mmc]
	mmc_spi host driver
Date: Fri, 16 Nov 2007 02:02:15 +0100
Message-ID: <200711160102.lAG12Fdo031436@ignucius.se.axis.com>
References: <200711151530.06591.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org, mikael.starvik-VrBV9hrLPhE@public.gmane.org,
	mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org
To: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <200711151530.06591.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> (message from David
	Brownell on Thu, 15 Nov 2007 15:30:05 -0800)
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

> From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
> Date: Thu, 15 Nov 2007 15:30:05 -0800

> On Tuesday 04 September 2007, Sascha Hauer wrote:
> > On Fri, Aug 31, 2007 at 04:00:51PM -0700, David Brownell wrote:
    (further attributions lost)
> > > > > > I tested this with six SD cards. They all behave like this except one
> > > > > > 512MB Kingston card which works. A MMC card I tested works too.
> > > > > > Maybe we have to use a single block transfer on the last sector?
> > > > > 
> > > > > Could be.  See what the current "Simplified SD" spec says ... I do
> > > > > recall language about reading that sector, but it didn't seem to
> > > > > matter for any of the cards I have for testing.  So I probably didn't
> > > > > pay enough attention to those words.
> > > >
> > > > Unfortunately I did not find anything about that in the spec.
> > > 
> > > I'm sure I saw that, but have no idea what document it was in.  If
> > > not the "Simplified" spec, then a vendor's card spec ... either
> > > Sandisk (MMC, SD), Samsung, Hitachi, whatever.
> > > 
> > 
> > Still did not find something about it. I looked in the simplified spec
> > and in vendor specs from Toshiba and Sandisk.
> 
> I'm still sure I saw it.  Maybe I'll try searching for that text
> myself, it's surely in one of half a dozen huge documents I have
> sitting around in PDF form.  ;)

That kind of rung a bell, and I just had to dive into my virtual
pile of MMC/SPI PDFs.  At time of this writing, the document is
still downloadable from www.sandisk.com.  The site changed since
I last was there, but once I just clicked my way to it:
<http://www.sandisk.com/Assets/File/OEM/Manuals/ProdManRS-MMCv1.3.pdf>.

In "Chapter 5 SPI Mode", section "5.14 Read Ahead in Multiple
Block Read Operation" on page 74, it says: "In Multiple Block
read operations, in order to improve read performance, the card
may fetch data from the memory array, ahead of the host. In this
case, when the host is reading the last addresses of the memory,
the card attempts to fetch data beyond the last physical memory
address and generates an OUT_OF_RANGE error. Therefore, even if
the host times the Stop Transmission command to stop the card
immediately after the last byte of data was read, the card may
already have generated the error, which will show in the
response to the Stop Transmission command. The host should
ignore this error."

HTH.

brgds, H-P
PS. FWIW, I've not been near MMC/SPI programming since January.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
