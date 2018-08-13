From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
Date: Mon, 13 Aug 2018 13:36:00 +0100
Message-ID: <20180813133600.180abc03@alans-desktop>
References: <20180701110804.32415-1-afaerber@suse.de>
 <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
 <92ee4016-1da9-826b-3674-b2d604a64848@suse.de>
 <20180808213640.10a1d76f@alans-desktop>
 <a70e9715-beac-d9a8-145e-de00175e56fa@suse.de>
 <20180809125939.39ac2cc9@alans-desktop>
 <CAC=mGzjn4Kc-q9NFwX6NhU4V_thnzBP8SHtFQKyRbpSKR=yx3w@mail.gmail.com>
 <20180810165711.59bf26f7@alans-desktop>
 <CAC=mGzhaLiSj5-+euM-YTRLwNDi8QJY0fAbiZbUadkPhZGRh_Q@mail.gmail.com>
 <11276f7d-0175-05e9-a9bd-c72868067081@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Michal =?UTF-8?B?S3ViZcSNZWs=?= <mkubecek@suse.cz>,
 Konstantin =?UTF-8?B?QsO2aG0=?= <konstantin.boehm@ancud.de>, shess@hessware.de,
 Pieter ROBYNS <pieter.robyns@uhasselt.be>,
 "contact@snootlab.com" <contact@snootlab.com>,
 Xue Liu <liuxuenetmail@gmail.com>, Ken Yu <ken.yu@rakwireless.com>,
 Michael =?UTF-8?B?UsO2ZGVy?= <michael.roeder@avnet.eu>,
 Stefan Schmidt <stefan@datenfreihafen.org>, Rob Herring <robh@kernel.org>,
 lora@globalsat.com.tw, Alexander Graf <agraf@suse.de>,
 Jan Jongboom <jan.jongboom@arm.com>, Janus Piwek <jpiwek@arroweurope.com>,
 Jon Ortego <Jon.Ortego@imst.de>, Jian-Hong Pan <starnight@g.ncu.edu.tw>,
 devicetree@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Hasnain Virk <Hasnain.Virk@arm.com>, Daniele Comel <dcomel@mipot.com>,
 Marcel Holtmann <marcel@holtmann.org>, Mark Brown <broonie@kernel.org>,
 Dollar Chen <dollar.chen@wtmec.com>, Brian Ray <brian.ray
To: Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <11276f7d-0175-05e9-a9bd-c72868067081@suse.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

> The simple answer is that, inspired by CAN, it uses an ifindex to select
> the interface the user asked to use. That then also answers Alan's next
> question: This ifindex determines which interface it goes out to.
> 
> sockaddr_lora was in patch 02/15, latest code here:
> https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-lora.git/tree/include/uapi/linux/lora.h?h=lora-next

And any loopback just becomes an ifindex, likewise any virtual lorawan
device (eg when testing in a cloud or simulating radio properties).

> I still think the user will need to explicitly say which interface they
> want to bind their socket to. AFAIU the device EUI is more comparable to

It does make it very hard for any vaguely complex environment because if
for example you have two interfaces enumerated via USB they will appear
in random order each boot.

CANbus is a bit of a mess in this sense but it's so statically configured
and embedded into industrial devices it's less of a problem.

I just wonder if the name would be a better binding (so you can sort the
order out), or a local physical identifier of some kind so that your
enumeration is consistent.

> Loopback mode would require a separate virtual device driver such as
> fakelr or vlora.

And a tunnel device, which is easy enough if you've got tap support or
similar.

Alan
