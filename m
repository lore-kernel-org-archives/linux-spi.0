From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/2] sparc: Enable OF functionality for sparc for i2c
 and spi
Date: Tue, 04 Dec 2012 16:10:01 -0500 (EST)
Message-ID: <20121204.161001.1397661306369063374.davem@davemloft.net>
References: <1354630178-25387-1-git-send-email-andreas@gaisler.com>
	<CACxGe6sw0zU0NcXw1gjMZka4WyTZgT4heF3r4k0QPHbfcPzbiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: andreas@gaisler.com, w.sang@pengutronix.de, sam@ravnborg.org,
	sparclinux@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	spi-devel-general@lists.sourceforge.net, linux-i2c@vger.kernel.org,
	software@gaisler.com
To: grant.likely@secretlab.ca
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <CACxGe6sw0zU0NcXw1gjMZka4WyTZgT4heF3r4k0QPHbfcPzbiw@mail.gmail.com>
Sender: sparclinux-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 4 Dec 2012 14:44:57 +0000

> On Tue, Dec 4, 2012 at 2:09 PM, Andreas Larsson <andreas@gaisler.com> wrote:
>> This series removes the dependency on !SPARC for OF_I2C and removes the
>> depencency of !defined(CONFIG_SPARC) for the function
>> of_register_spi_devices. I find no reason for these to be unavailable
>> for sparc.
>>
>> I am not sure if these should go through the sparc tree or the
>> corresponding subsystem trees.
> 
> They should go through the subsystem trees.

I'll take this into the sparc tree after some build testing, thanks.
