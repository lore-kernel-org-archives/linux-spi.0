From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
Date: Fri, 10 Aug 2018 16:57:11 +0100
Message-ID: <20180810165711.59bf26f7@alans-desktop>
References: <20180701110804.32415-1-afaerber@suse.de>
 <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
 <92ee4016-1da9-826b-3674-b2d604a64848@suse.de>
 <20180808213640.10a1d76f@alans-desktop>
 <a70e9715-beac-d9a8-145e-de00175e56fa@suse.de>
 <20180809125939.39ac2cc9@alans-desktop>
 <CAC=mGzjn4Kc-q9NFwX6NhU4V_thnzBP8SHtFQKyRbpSKR=yx3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Michal =?UTF-8?B?S3ViZcSNZWs=?= <mkubecek@suse.cz>,
 Konstantin =?UTF-8?B?QsO2aG0=?= <konstantin.boehm@ancud.de>, shess@hessware.de,
 pieter.robyns@uhasselt.be, "linux-kernel@vger.kernel.org>,
 " <contact@snootlab.com>, Xue Liu <liuxuenetmail@gmail.com>,
 Ken Yu <ken.yu@rakwireless.com>,
 Michael =?UTF-8?B?UsO2ZGVy?= <michael.roeder@avnet.eu>,
 Stefan Schmidt <stefan@datenfreihafen.org>, Rob Herring <robh@kernel.org>,
 lora@globalsat.com.tw, Alexander Graf <agraf@suse.de>,
 Jan Jongboom <jan.jongboom@arm.com>, Janus Piwek <jpiwek@arroweurope.com>,
 Jon Ortego <Jon.Ortego@imst.de>, devicetree@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>, Hasnain Virk <Hasnain.Virk@arm.com>,
 Daniele Comel <dcomel@mipot.com>, Marcel Holtmann <marcel@holtmann.org>,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Dollar Chen <dollar.chen@wtmec.com>, Brian Ray <brian.ray@link-labs.com>,
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAC=mGzjn4Kc-q9NFwX6NhU4V_thnzBP8SHtFQKyRbpSKR=yx3w@mail.gmail.com>
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

> Except saving power, mitigating the wireless signal conflict on the
> air is one of the reasons.

If the device level is always receiving when not transmitting it has no
effect on this. The act of listening does not harm other traffic.

> The sleep/idle/stop mitigate the unconcerned RF signals or messages.

At the physical level it's irrelevant. If we are receiving then we might
hear more things we later discard. It's not running on a tiny
microcontroller so the extra CPU cycles are not going to kill us.

> > How do you plan to deal with routing if you've got multiple devices ?  
> 
> For LoRaWAN, it is a star topology.

No the question was much more how you plan to deal with it in the OS. If
for example I want to open a LORA connection to something, then there
needs to be a proper process to figure out where the target is and how to
get traffic to them.

I guess it's best phrased as

- What does a struct sockaddr_lora look like

- How does the kernel decide which interface it goes out of (if any), and
  if it loops back

remembering we might only be talking to a hub, or we might even be a
virtualized LORA interface where we are pretending to be some kind of
sensor and feeding it back.

Long term yes I think Alexander is right the inevitable fate of all
networks is to become a link layer in order to transmit IP frames 8)

Alan
