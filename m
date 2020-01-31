From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: spi-fsl-espi driver issue
Date: Fri, 31 Jan 2020 21:48:47 +0100
Message-ID: <712e53ad-9482-d767-7995-35634e58e5bd@gmail.com>
References: <CADQNx5QsXRSyrJxEXLQr3oYyy+-xnYrH_txbA+37macNVZkHcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Andrij Abyzov <drolevar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CADQNx5QsXRSyrJxEXLQr3oYyy+-xnYrH_txbA+37macNVZkHcw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 31.01.2020 10:34, Andrij Abyzov wrote:
> Heiner,
> 
> I'm having a strange issue with the spi-fsl-espi driver when updating the firmware on Lattice MachXO2 FPGA.
> It worked fine with the version 4.9, however one of the subsequent changes has led to the issue, that the read result is shifted right by 1 bit.
> I understand this could be something due to polarity, phase or frequency, but it did work fine with 4.9 and before.
> Now I'm trying to localize the issue by bisection, but that's a lengthy process and I thought that maybe you could have some insights.
> 
I'm not the maintainer of this driver, so better set the linux-spi list on cc.

Which device tree config is used? Or do you set a specific mode manually?

> Best regards,
> Andrij Abyzov

Heiner
