From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: Re: [RFC 1/3 net] lorawan: Add LoRaWAN class module
Date: Wed, 26 Sep 2018 23:52:50 +0800
Message-ID: <CAC=mGzjFHJi1VHKCXa-dM5XBsbXo_s1QqpPdbLF0+3BdhVMR2Q@mail.gmail.com>
References: <cover.1535039998.git.starnight@g.ncu.edu.tw> <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
 <cebcea44-9db3-5564-574c-038d9af79995@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: netdev@vger.kernel.org,
        "<linux-arm-kernel@lists.infradead.org\\"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?Q?Michael_R=C3=B6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?Q?Konstantin_B=C3=B6hm?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
        Jon Ortego <Jon.Ortego@imst.de>,
        "linux-kernel@vger.kernel.org>," <contact@snootlab.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Brian Ray <brian.ray@link-labs.com>, lora@g
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cebcea44-9db3-5564-574c-038d9af79995@suse.de>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Andreas F=C3=A4rber <afaerber@suse.de> =E6=96=BC 2018=E5=B9=B49=E6=9C=8824=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8812:40=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi Jian-Hong,
>
> [+ Afonso]
>
> Am 23.08.18 um 19:15 schrieb Jian-Hong Pan:
> > LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa devices=
.
> >
> > This patch implements part of Class A end-devices features defined in
> > LoRaWAN(TM) Specification Ver. 1.0.2:
> > 1. End-device receive slot timing
> > 2. Only single channel and single data rate for now
> > 3. Unconfirmed data up/down message types
> > 4. Encryption/decryption for up/down link data messages
> >
> > It also implements the the functions and maps to Datagram socket for
> > LoRaWAN unconfirmed data messages.
> >
> > On the other side, it defines the basic interface and operation
> > functions for compatible LoRa device drivers.
> >
> > Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> > ---
> >  include/linux/maclorawan/lora.h | 239 +++++++++++
> >  net/maclorawan/Kconfig          |  14 +
> >  net/maclorawan/Makefile         |   2 +
> >  net/maclorawan/lorawan.h        | 219 ++++++++++
> >  net/maclorawan/lrwsec.c         | 237 +++++++++++
> >  net/maclorawan/lrwsec.h         |  57 +++
> >  net/maclorawan/mac.c            | 552 +++++++++++++++++++++++++
> >  net/maclorawan/main.c           | 665 ++++++++++++++++++++++++++++++
> >  net/maclorawan/socket.c         | 700 ++++++++++++++++++++++++++++++++
> >  9 files changed, 2685 insertions(+)
> >  create mode 100644 include/linux/maclorawan/lora.h
>
> Can we use include/linux/lora/lorawan.h for simplicity?

Technically, yes

> >  create mode 100644 net/maclorawan/Kconfig
> >  create mode 100644 net/maclorawan/Makefile
> >  create mode 100644 net/maclorawan/lorawan.h
> >  create mode 100644 net/maclorawan/lrwsec.c
> >  create mode 100644 net/maclorawan/lrwsec.h
> >  create mode 100644 net/maclorawan/mac.c
> >  create mode 100644 net/maclorawan/main.c
> >  create mode 100644 net/maclorawan/socket.c
>
> This patch is much too large for me to review...
>
> It also doesn't seem to follow the structure I suggested: 802.15.4 has
> two separate directories, net/ieee802154/ and net/mac802154/. Therefore
> I had suggested net/maclorawan/ only for code that translates from
> ETH_P_LORAWAN to ETH_P_LORA socket buffers, i.e. your soft MAC. Generic
> socket code that applies also to hard MAC drivers I expected to go
> either to net/lora/lorawan/ or better net/lorawan/ or some other clearly
> separate location, with its own Kconfig symbol - any reason not to?
> Consider which parts can be enabled/used independently of each other,
> then you can put them into two (or more?) different patches.

Maybe I misunderstood before.  Besides, the header files need to be
split for different paths or folders.
Anyway, I will try to separate it into parts in version 2 patches.

> Also please use SPDX license identifiers in your headers.
> And please don't put the whole world in To, use CC.

Regards,
Jian-Hong Pan
