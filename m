From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/2] mcspi: Add support for GPIO chip select lines
Date: Thu, 03 Mar 2011 14:42:07 -0700
Message-ID: <f7a269db-3bcf-4bac-8c38-b363e5c7bd0b@email.android.com>
References: <c0ffcf4415b8edbf55d653a620b92fbbbcd8fed7>
	<1297635034-24504-1-git-send-email-bgamari.foss@gmail.com>
	<20110302215026.GA22854@angua.secretlab.ca>
	<87sjv517yd.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
To: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <87sjv517yd.fsf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org



Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

>> Yes, this is a better approach. However, I'd rather see the gpio
>data
>> passed as an array to the spi master platform_device via the
>> private_data structure.
>
>Sorry for my ignorance but I really have no idea how one would hook
>this
>up in the board code (which IMHO is where this sort of chip select
>configuration belongs). Looking at the beagleboard board file I see no
>reference to a spi master platform_device. The SPI devices are
>registered
>through spi_register_board_info. Could you clarify how this would work?

The spi_master platform device is registered somewhere in the inappropriate support code. You need to arrange to make sure the correct pdata is attached to it when it gets registered. There /should/ be a mechanism for doing so.

All spi devices already specify a cs number anyway. What you can do is use the cs number as the lookup index into the gpio table, and remember to reserve a cs# for the 'native' cs line.

g.

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
------------------------------------------------------------------------------
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
