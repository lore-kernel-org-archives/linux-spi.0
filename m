From: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
Subject: Re: [PATCH v2] spi: add OpenCores tiny SPI driver
Date: Mon, 24 Jan 2011 11:59:54 +0100
Message-ID: <1295866794.23825.100.camel@needafix>
References: <1294800109-31603-1-git-send-email-thomas@wytron.com.tw>
	<1295249542-26743-1-git-send-email-thomas@wytron.com.tw>
	<20110120165430.GA24445@angua.secretlab.ca>
	<4D38AAEB.7020308@wytron.com.tw> <1295612849.23825.26.camel@needafix>
	<4D3CD38D.4080808@wytron.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4D3CD38D.4080808-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Thomas,

> > Versioning of OpenCores cores is not sorted yet.  In order to avoid
> > clashing with the versioning/naming scheme that's decided on, please
> > just use a neutral version number for now (especially as your core is so
> > new).  e.g. "opencores,tiny-spi-0"
> >
> 
> Thanks. I will update it to "opencores,tiny-spi-1.0".
> 

We've discussed this a bit internally now and decided that the best way
to version OpenCores cores is to use the SVN commit ID of the rtl/
directory in the project's repository.  So, for your tiny-spi project,
the last SVN commit to update the rtl/ directory was commit number 2;
hence, I'd recommend you use the following device tree identifier:

opencores,tiny-spi-rtlsvn2

That's:  opencores,<project>-rtl<VCS><commit ID>

As projects are currently in SVN, VCS=svn.

Linux drivers for other OpenCores cores will be updated accordingly.

/Jonas


------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
