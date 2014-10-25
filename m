From: V JobNickname <workofv@gmail.com>
Subject: Does spi-gpio and bitband support 3-wire Bidirectional most/miso
 share pin usage?
Date: Sun, 26 Oct 2014 04:21:18 +0800
Message-ID: <CANHbGWtbjgLGmy_CxBJ43XVfq6zaaqFvmWWCAXe7NEidO9_fFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-kernel@vger.kernel.org
To: linux-spi@vegr.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

I have a device use 3-wire spi which are CS,SCK,and a DATA for
read/write.( maybe a.s.k.a SISO)
The command format like as p.18 in
www .newhavendisplay .com/app_notes/NV3035C.pdf

The spi-gpio can't register miso and mosi for same GPIO pin.
Also I traced SPI-3WIRE flag it seems only support half 3-wire which
only write or only read but share ping

Does current driver can support this kind of 3wire spi format? Or I
need to do some modify to support this 3-wire spi
