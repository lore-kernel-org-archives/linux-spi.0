From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 6/6] of_spi: Initialize cs_gpios and cs_gpio with
	-EEXIST
Date: Tue, 12 Feb 2013 10:46:27 +0100
Message-ID: <511A0F73.50008@gaisler.com>
References: <1359471223-4794-1-git-send-email-andreas@gaisler.com>
	<1359471223-4794-7-git-send-email-andreas@gaisler.com>
	<20130211002320.824593E0C13@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130211002320.824593E0C13@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 2013-02-11 01:23, Grant Likely wrote:
> On Tue, 29 Jan 2013 15:53:43 +0100, Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org> wrote:
>> Holes in the cs-gpios DT phandle list is supposed to mark that native
>> chipselects is to be used. The value returned from of_get_named_gpio_flags in
>> this case is -EEXIST. By initializing cs_gpios and cs_gpio with -EEXIST, this
>> and only this errno will indicate to a spi controller driver that a native
>> chipselect is to be used.
>>
>> Signed-off-by: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
>
> I've left this one off for now. Take a look at the patch I posted and
> let me know if you think this one should still be applied.

I think that of_spi_register_master should return an error when the 
cs-gpios property is broken (part of patch 2) and that cs_gpios and 
cs_gpio should be initialized to the same value as a hole in the plist.

This patch does not work without 1 and 2, so I'll submit a modified 
patch once "of: Create function for counting number of phandles in a 
property" has stabilized. Would it have to go through the gpio branch then?

Cheers,
Andreas


------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
