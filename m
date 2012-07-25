From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: [PATCH 1/2] SPI: spi-gpio: store chipselect information in
	private structure
Date: Wed, 25 Jul 2012 20:52:03 +0100
Message-ID: <20120725195203.GC9792@sirena.org.uk>
References: <1343216652-1463-1-git-send-email-zonque@gmail.com>
	<20120725193359.GB9792@sirena.org.uk> <50104B52.7090509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50104B52.7090509-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jul 25, 2012 at 09:38:58PM +0200, Daniel Mack wrote:
> On 25.07.2012 21:33, Mark Brown wrote:

> > Always CC maintainers on things...  you've not CCed Grant or Linus W,
> > and for now I'm handling SPI patches (though I'm not in MAINTAINERS so
> > missing me is less surprising).

> I *did* Cc: Grant and all other people that get_maintainer.pl listed.
> For some reason, Grant was dropped from the list on Wolfram's reply, and
> I just did't see that.

Grant's not in the CCs for the message I replied to which was one of
your patches.

> Anyway - let's rather discuss about the patchset :)

Part of the reason I'm being grumpy is I'm not likely to look at it
right now and my workflow is heavily based on things hitting my inbox
(I use a totally different account for generic list mail I'm not CCed on
and it's annoying to move stuff from one to the other).

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
