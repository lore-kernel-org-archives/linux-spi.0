From: "Herbrechtsmeier Dr.-Ing. , Stefan"
        <stefan.herbrechtsmeier-oss-2t/0UIm1CeVDOHtkgc7UlQ@public.gmane.org>
Subject: Execute spi transfers inside FIQ (NMI) or panic
Date: Tue, 25 Feb 2020 14:27:27 +0100
Message-ID: <b22800b8-9c03-63a5-7ade-d8b63c562580@weidmueller.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

would it be acceptable to add an additional function to the struct 
spi_controller which handle a transfer inside a NMI context or a panic? 
The new function will transfer data via register polling without any lock.

I must execute an SPI transfer inside a fast interrupt request (FIQ) 
handler or a panic. The FIQ is handled as a non-maskable interrupt 
(NMI). Both the panic and the NMI doesn't support any interrupts.

The background of the request is a non-volatile SPI memory with cached 
date in system memory. The cache must be synchronized back to the SPI 
memory after a power failure or panic.

Regards
   Stefan Herbrechtsmeier

**
