From: Igor Plyatov <plyatov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: spi-atmel.c: problem with PDC on AT91SAM9G20
Date: Thu, 5 Oct 2017 10:18:09 +0300
Message-ID: <503ccb36-fab0-6e0c-b9cc-f814ab64a1aa@gmail.com>
References: <de4b4952-35a0-fd95-6adf-9219385644e9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <de4b4952-35a0-fd95-6adf-9219385644e9-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello!


> Data corruption happens during receiving of SPI data by kernel. It 
> happens quite often (once per minute or so) if OS has some light load, 
> like periodical writes to SD card in parallel with communication to 
> SPI device (DSP).
... skipped


For those, who has same interest or encountered the same issue as I had...

Notes:
A) My "gs_mgms_dsp" linux driver is the same for linux-2.6.39 and 
linux-4.9.36
    and communicates with DSP through SPI-bus, where data packets are 32 
byte
    long and last byte is CRC8 to check data integrity.
B) CPU is AT91SAM9G20.

I have encoutered SPI data corruption during receiving of data from DSP by
linux-4.9.36 if SPI-bus has big traffic in parallel with big traffic at MMC
interface.

Old linux-2.6.39 does not suffer from such issue, because atmel-mci.c 
driver has
PIO access to MMC interface. While new kernel has changed the 
atmel-mci.c driver
for use of PDC (Peripheral DMA Controller) for access to MMC interface.

Both kernels have Atmel SPI driver where PDC used for SPI data transfers.

SPI data corruption looks like duplication of one of received bytes.
Such bytes surrounded by "**" at log below.

gs_mgms_dsp spi32766.0: CRC error.
gs_mgms_dsp spi32766.0: <- 35 36 37 38 39 3A 3B 3C 3D  3E 3F  40 41 42 43 44
gs_mgms_dsp spi32766.0: <- 45 46 47 48 49 4A 4B 4C 4D *4F 4F* 50 51 52 53 A4
gs_mgms_dsp spi32766.0: -> EIO=0x05
gs_mgms_dsp spi32766.0: CRC error.
gs_mgms_dsp spi32766.0: <- 0F C2 C3 C4 C5 C6 C7 C8 C9  CA CB  CC CD CE CF D0
gs_mgms_dsp spi32766.0: <- D1 D2 D3 D4 D5 D6 D7 D8 D9 *DB DB* DC DD DE DF 02
gs_mgms_dsp spi32766.0: -> EIO=0x05
gs_mgms_dsp spi32766.0: CRC error.
gs_mgms_dsp spi32766.0: <-  03 5A  5B 5C 5D 5E 5F 60 61 62 63 64 65 66 67 68
gs_mgms_dsp spi32766.0: <- *6A 6A* 6B 6C 6D 6E 6F 70 71 72 73 74 75 76 77 25
gs_mgms_dsp spi32766.0: -> EIO=0x05
gs_mgms_dsp spi32766.0: CRC error.
gs_mgms_dsp spi32766.0: <- 15 76 77 78 79 7A  7B 7C  7D 7E 7F 80 81 82 83 84
gs_mgms_dsp spi32766.0: <- 85 86 87 88 89 8A *8C 8C* 8D 8E 8F 90 91 92 93 00
gs_mgms_dsp spi32766.0: -> EIO=0x05
gs_mgms_dsp spi32766.0: CRC error.
gs_mgms_dsp spi32766.0: <- 2A EC ED EE EF F0 F1  F2 F3  F4 F5 F6 F7 F8 F9 FA
gs_mgms_dsp spi32766.0: <- FB FC FD FE FF 00 01 *03 03* 04 05 06 07 08 09 0A
gs_mgms_dsp spi32766.0: -> EIO=0x05

This looks like silent SPI overruns not detected by AT91SAM9G20 HW.

At the end, after some seconds or milliseconds of communication, HW SPI 
overrun
flag detected by the spi-atmel.c driver:
"atmel_spi fffcc000.spi: overrun (0/0 remaining)".

Strictly speaking this is not a regression of spi-atmel.c, but unfortunate
combination with atmel-mmc.c, where PDC used too and I suppose a HW bug in
AT91SAM9G20 CPU.

Please help to answer on questions:
   1) How to modify atmel-mci.c driver to have option for PIO access to MMC
      interface?
   2) Why SPI overrun flag does not asserted each time? I have not found 
such HW bug
      in the Errata for AT91SAM9G20 CPU.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
