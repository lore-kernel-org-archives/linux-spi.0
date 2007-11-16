From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 4/4 2.6.23-rc2 + mm2-git-mmc]
	mmc_spi host driver
Date: Fri, 16 Nov 2007 12:28:25 -0800
Message-ID: <200711161228.25798.david-b@pacbell.net>
References: <200711160102.lAG12Fdo031436@ignucius.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mikael.starvik-VrBV9hrLPhE@public.gmane.org,
	mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org, drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org
To: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200711160102.lAG12Fdo031436-PT6ZA4s7Vg53Mq0XhIy4CVaTQe2KTcn/@public.gmane.org>
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

On Thursday 15 November 2007, Hans-Peter Nilsson wrote:
> That kind of rung a bell, and I just had to dive into my virtual
> pile of MMC/SPI PDFs.  At time of this writing, the document is
> still downloadable from www.sandisk.com.  The site changed since
> I last was there, but once I just clicked my way to it:
> <http://www.sandisk.com/Assets/File/OEM/Manuals/ProdManRS-MMCv1.3.pdf>.
> 
> In "Chapter 5 SPI Mode", section "5.14 Read Ahead in Multiple
> Block Read Operation" on page 74,

This seems to be what I was thinking about, thanks.


> it says: "In Multiple Block 
> read operations, in order to improve read performance, the card
> may fetch data from the memory array, ahead of the host. In this
> case, when the host is reading the last addresses of the memory,
> the card attempts to fetch data beyond the last physical memory
> address and generates an OUT_OF_RANGE error. Therefore, even if
> the host times the Stop Transmission command to stop the card
> immediately after the last byte of data was read, the card may
> already have generated the error, which will show in the
> response to the Stop Transmission command. The host should
> ignore this error."
> 
> HTH.

Yes, but it doesn't quite explain the specific failure mode
being observed ... which is a CRC error on the STOP command,
rather than an OUT_OF_RANGE token replacing start-of-data.

It's a small puzzle...

- Dave



> 
> brgds, H-P
> PS. FWIW, I've not been near MMC/SPI programming since January.
> 



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
