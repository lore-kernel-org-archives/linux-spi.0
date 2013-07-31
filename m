From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCHv7 1/2] drivers: spi: Add qspi flash controller
Date: Wed, 31 Jul 2013 15:23:07 +0530
Message-ID: <51F8DE83.9010901@ti.com>
References: <1375249673-2585-1-git-send-email-sourav.poddar@ti.com> <1375249673-2585-2-git-send-email-sourav.poddar@ti.com> <20130731074952.GA14517@radagast> <51F8D49B.2090307@ti.com> <20130731092008.GC14517@radagast> <51F8DB98.70709@ti.com> <20130731094857.GA15583@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <broonie@kernel.org>, <spi-devel-general@lists.sourceforge.net>,
	<grant.likely@linaro.org>, <linux-omap@vger.kernel.org>,
	<rnayak@ti.com>
To: <balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20130731094857.GA15583@radagast>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wednesday 31 July 2013 03:18 PM, Felipe Balbi wrote:
> Hi,
>
> On Wed, Jul 31, 2013 at 03:10:40PM +0530, Sourav Poddar wrote:
>>>> words can be of any length (1, 2 or 4) bytes. So, I think it should be
>>>> decremented by 1 only.
>>> this is wrong.
>>>
>> hmm..got the point.
>> I will pass the count address also to ti_qspi_read_data/write_data and make
>> use of the switch statement to decrement the count.
> why don't you return the amount of bytes to decrement in case of
> success ?
>
Yes, that can be done to tackle this. Thanks!
