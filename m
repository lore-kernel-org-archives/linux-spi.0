From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [patch 0/4 2.6.23-rc2 + mm2-git-mmc]	latest
	MMC-over-SPI support
Date: Thu, 9 Aug 2007 14:45:16 +0400
Message-ID: <20070809104516.GA16983@localhost.localdomain>
References: <200708080906.18993.david-b@pacbell.net>
Reply-To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200708080906.18993.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Wed, Aug 08, 2007 at 09:06:18AM -0700, David Brownell wrote:
> Same deal as before ... refreshed against the latest git-mmc.patch,
> four patches:
> 
>  - headers
>  - block
>  - core
>  - mmc_spi host
> 
> Differences from the very last patches sent are primarily that this one
> includes the lock/unlock changes again (since it's against git-mmc not
> against kernel.org), and code for the SDIO stuff is there (ditto).  But
> also, a few more of Pierre's comments have kicked in.
> 
> I'm hoping this version gets merged into git-mmc.  :)

Works great here. Thanks!

-- 
Anton Vorontsov
email: cbou-JGs/UdohzUI@public.gmane.org
backup email: ya-cbou-o+MxOtu4lMCHXe+LvDLADg@public.gmane.org
irc://irc.freenode.net/bd2

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
