From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] SPI: spi-gpio: store chipselect information in private
	structure
Date: Wed, 25 Jul 2012 21:38:58 +0200
Message-ID: <50104B52.7090509@gmail.com>
References: <1343216652-1463-1-git-send-email-zonque@gmail.com>
	<20120725193359.GB9792@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
To: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120725193359.GB9792-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 25.07.2012 21:33, Mark Brown wrote:
> On Wed, Jul 25, 2012 at 01:44:11PM +0200, Daniel Mack wrote:
>> The spi-gpio driver currently assumes the chipselect gpio number is
>> stored in ->controller_data of the device's static board information.
> 
> Always CC maintainers on things...  you've not CCed Grant or Linus W,
> and for now I'm handling SPI patches (though I'm not in MAINTAINERS so
> missing me is less surprising).

I *did* Cc: Grant and all other people that get_maintainer.pl listed.
For some reason, Grant was dropped from the list on Wolfram's reply, and
I just did't see that.

$ scripts/get_maintainer.pl -f drivers/spi/spi-gpio.c

                                                         (0) [21:35:24]
Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> (maintainer:SPI SUBSYSTEM)
Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org> (maintainer:OPEN FIRMWARE AND...)
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org (open list:SPI SUBSYSTEM)
linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list)
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org (moderated list:OPEN FIRMWARE AND...)

And I didn't know about you being in charge for SPI (saw that only today
when you sent your pull request to lkml). So, sorry.

Anyway - let's rather discuss about the patchset :)


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
