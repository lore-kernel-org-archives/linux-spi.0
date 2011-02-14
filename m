From: "Gorby, Russ" <russ.gorby@intel.com>
Subject: RE: [PATCH 0/1] Adding intel_mid_ssp_spi driver : 01/27/2011
Date: Mon, 14 Feb 2011 09:22:49 -0800
Message-ID: <4C5E6457CD7911469A07260381288C28D37127C9@orsmsx502.amr.corp.intel.com>
References: <1296680512-2758-1-git-send-email-russ.gorby@intel.com>
 <20110212091913.GD17755@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	"open list:SPI SUBSYSTEM" <spi-devel-general@lists.sourceforge.net>,
	open list <linux-kernel@vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110212091913.GD17755@angua.secretlab.ca>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

OK got it. Thanks.

>-----Original Message-----
>From: Grant Likely [mailto:glikely@secretlab.ca] On Behalf Of Grant
>Likely
>Sent: Saturday, February 12, 2011 1:19 AM
>To: Gorby, Russ
>Cc: David Brownell; open list:SPI SUBSYSTEM; open list
>Subject: Re: [PATCH 0/1] Adding intel_mid_ssp_spi driver : 01/27/2011
>
>On Wed, Feb 02, 2011 at 01:01:51PM -0800, Russ Gorby wrote:
>> Hello SPI maintainers,
>> I am sending a patch for the (new) intel_mid_ssp_spi driver for
>> consideration for inclusion in the Linux Kernel. This is a SPI master
>> controller driver that is being used for the intel MID platform
>(Medfield).
>> It uses the on-board Bulverde SSP controller configured for SPI
>(spibus #3)
>> running at 25Mhz.
>
>Hi Russ,
>
>Just for future reference, when you're only sending one patch, please
>put your notes into the patch description itself, or immediately after
>the --- line.  No need for a cover letter like this one.
>
>Thanks,
>g.
