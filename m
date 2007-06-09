From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 2.6.22-rc4 8/7] mmc_spi
 cid/csd/ext_csd updates, CRCs on
Date: Sat, 09 Jun 2007 22:55:33 +0200
Message-ID: <466B13C5.3050502@drzeus.cx>
References: <200706042025.18252.david-b@pacbell.net>
	<200706051013.44971.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706051013.44971.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

David Brownell wrote:
> Fix some of the "register"/descriptor access glitches in the
> preceding patches:
> 
>   - Updated internal routines:
>       * previous mmc_send_cxd() renamed to mmc_send_cxd_native(); it
>         uses native "R2" responses, which include 16 bytes of data.
>       * previous mmc_send_ext_csd() becomes new mmc_send_cxd_data()
>         helper for command-and-data access
> 
>   - Modified mmc_send_ext_csd() now uses mmc_send_cxd_data() helper
> 
>   - New mmc_send_csd() and mmc_spi_send_cid() routines now use one
>     of those helper routines based on whether they're native or SPI;
> 
>   - Remove ugly "R1D" response pseudo-type for SPI
> 
>   - Make it OK for MMC cards to try SEND_EXT_CSD; v4+ needs that
> 
>   - Turn CRCs back on by default with the SPI protocol
> 
> So this resolves most of the technical issues I know about, leaving
> nontechnical ones like "is this code clean enough" or "is this how
> we want to solve that problem".
> 
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Instead of me reviewing the broken set of patches, can you merge these fixes in
and resend the set?

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
