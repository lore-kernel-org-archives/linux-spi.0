From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v5 0/5] Patch enables support for m25p64 SPI flash support
 on da850-EVM.
Date: Mon, 15 Apr 2013 17:18:59 +0530
Message-ID: <516BE92B.90002@ti.com>
References: <1364998150-5980-1-git-send-email-prakash.pm@ti.com> <A73F36158E33644199EB82C5EC81C7BC3EA4C560@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	"rob@landley.net" <rob@landley.net>,
	"linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"hs@denx.de" <hs@denx.de>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"davinci-linux-open-source@linux.davincidsp.com"
	<davinci-linux-open-source@linux.davincidsp.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>
To: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <A73F36158E33644199EB82C5EC81C7BC3EA4C560@DBDE01.ent.ti.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 4/9/2013 11:14 AM, Manjunathappa, Prakash wrote:
> Hi Grant,
> 
> On Wed, Apr 03, 2013 at 19:39:05, Manjunathappa, Prakash wrote:
>> Testing information:
>> da850-evm comes with partitions specified in DT blob.
>> Able to mount/umount and create/delete files on filesystem partition.
>>
> 
> Could you please ack the driver(1/5) and documentation(2/5) changes so
> that Sekhar can merge the platform changes, he doesn't have any
> objection on this series.
> http://marc.info/?l=linux-doc&m=136489750130615&w=1

I am planning to queue these patches for ARM-SoC today. Grant has not
acked these but 1/5 just fixes the binding name to not use wild cards
and 2/5 just documents existing bindings and is something that should
have been merge last merge window itself (when the bindings were
accepted). So, the patches pending on Grant's ack seem very low risk to
me and we are much delayed already to wait further.

Thanks,
Sekhar
