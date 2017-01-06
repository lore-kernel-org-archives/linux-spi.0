From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH 1/1] spi: imx: support to set watermark level via DTS
Date: Fri, 6 Jan 2017 01:00:00 -0800
Message-ID: <586F5C90.5070108@mentor.com>
References: <20170105061015.7816-1-jiada_wang@mentor.com> <20170105175854.gj5xr5drk5tddzyz@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
To: "Mark Brown vladimir_zapolskiy@mentor.com" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170105175854.gj5xr5drk5tddzyz@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello Mark and Vladimir

On 01/05/2017 09:58 AM, Mark Brown wrote:
> On Thu, Jan 05, 2017 at 03:10:15PM +0900, Jiada Wang wrote:
>
>> Previously watermark level is configured to fifosize/2,
>> DMA mode can be used only when transfer length can be divided
>> by 'watermark level * bpw', which makes DMA mode not practical.
>> This patch adds new DTS property 'dma-wml', user can configure
>> DMA watermark level, by specify 'dma-wml' in corresponding ecspi
>> node.
> Doesn't this just move the problem around a bit - can we not have the
> driver figure out a more sensible watermark for each transfer rather
> than fixing one in the DT?
I would like to submit another version of patch to adjust watermark level
based on transfer length. to use largest number (< fifosize / 2 ) which 
can divide
(transfer_length / bytes_per_work).

Thanks,
Jiada
