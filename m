From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH 0/2] sparc: Enable OF functionality for sparc for i2c
 and spi
Date: Tue, 04 Dec 2012 16:01:51 +0100
Message-ID: <50BE105F.3080403@gaisler.com>
References: <1354630178-25387-1-git-send-email-andreas@gaisler.com> <CACxGe6sw0zU0NcXw1gjMZka4WyTZgT4heF3r4k0QPHbfcPzbiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Miller <davem@davemloft.net>,
	Wolfram Sang <w.sang@pengutronix.de>,
	Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	spi-devel-general@lists.sourceforge.net,
	Linux I2C <linux-i2c@vger.kernel.org>, software@gaisler.com
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <CACxGe6sw0zU0NcXw1gjMZka4WyTZgT4heF3r4k0QPHbfcPzbiw@mail.gmail.com>
Sender: sparclinux-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 2012-12-04 15:44, Grant Likely wrote:
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
>
> What build testing have you done on these patches?

I have built under sparc32 (leon sparc to be specific) and have 
confirmed that of_register_spi_devices and of_i2c_register_devices works 
fine.

Cheers,
Andreas

