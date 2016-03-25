From: Lakshmi Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: RE: [LINUX PATCH 1/2] mtd: Added dummy entry in the spi_transfer
 structure.
Date: Fri, 25 Mar 2016 13:41:16 +0000
Message-ID: <4FF8F58FAA9D5D4193D4E554E4352C5902C6DB59@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <1458562809-36114-1-git-send-email-lakshmis@xilinx.com>
 <20160321130734.GS2566@sirena.org.uk>
 <4FF8F58FAA9D5D4193D4E554E4352C5902C6D34C@XAP-PVEXMBX02.xlnx.xilinx.com>
 <20160322100615.GA2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Cc: Marek Vasut <marex@denx.de>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Stephen Warren <swarren@nvidia.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Harini Katakam <harinik@xilinx.com>,
 =?iso-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Andrew F. Davis" <afd@ti.com>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 Michal Simek <michals@xilinx.com>, Soren Brinkmann <sorenb@xilinx.com>,
 Anirudha Sarangi <anirudh@xilinx.com>,
 Punnaiah Choudary Kalluri <punnaia@xilinx.com>,
 Jagan Teki <jteki@openedev.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160322100615.GA2566@sirena.org.uk>
Content-Language: en-US
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

Hi Mark,

>-----Original Message-----
>From: Mark Brown [mailto:broonie@kernel.org]
>Sent: Tuesday, March 22, 2016 3:36 PM
>To: Lakshmi Sai Krishna Potthuri
>Cc: Michal Simek; Soren Brinkmann; David Woodhouse; Brian Norris; Javier
>Martinez Canillas; Boris Brezillon; Stephen Warren; Geert Uytterhoeven;
>Andrew F. Davis; Marek Vasut; Jagan Teki; Rafa=B3 Mi=B3ecki; linux-
>mtd@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
>spi@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Harini Katakam;
>Punnaiah Choudary Kalluri; Anirudha Sarangi
>Subject: Re: [LINUX PATCH 1/2] mtd: Added dummy entry in the spi_transfer
>structure.
>
>On Tue, Mar 22, 2016 at 06:39:51AM +0000, Lakshmi Sai Krishna Potthuri
>wrote:
>
>Please fix your mail client to word wrap within paragraphs at something
>substantially less than 80 columns.  Doing this makes your messages much
>easier to read and reply to.  Please also avoid reflowing other text into =
longer
>lengths, this makes things worse.
>
>> >This isn't enough to add the feature - a client driver trying to make
>> >use of this needs to be able to tell if the cycles are actually going
>> >to be inserted.  I'd expect to see a capability flag that can be
>> >checked and some error checking so that if we try to do a transfer
>> >with dummy cycles and can't support it we don't silently ignore the
>> >dummy cycles, ideally also something that'll handle multiples of 8
>> >bits with SPI controllers that don't otherwise support this feature.
>
>> Currently, all fast reads use 8 cycles or 1 byte of dummy. This generally
>works.
>> But it can be vary based on the flash and the type of read command.
>> Dummy bytes are taken care of in m25p80.c by adjusting the len field:
>> Length =3D size of (command + address + dummy byte)
>
>> There might be controllers (like ZynqMP GQSPI) that would be able to
>> use the information that dummy byte(s) were added and the precise
>> number of dummy cycles. This patch does not disturb the existing
>> implementation of adjusting length (as described above). It adds an
>additional optional feature.
>> So there is no harm to controllers that can't support it - they can
>> ignore it and still work with the existing "length adjustment"
>implementation.
>> If you think there value in adding a capability flag, please let me know.
>
>This is really not what I'd expect to happen, I'd expect that these dummy
>cycles would be in addition to the actual data (see my request for better
>documentation...).  If they overlap with the data then what is the point in
>specifying this?  It's more work for the host, what benefit do we get from
>doing it over just handing it like a normal byte?

len field in the transfer structure contains dummy bytes along with actual =
data
bytes, controllers which requires dummy bytes use len field and simply Igno=
re
the dummy field (contains only no of cycles)added in this patch. Controllers
(like ZynqMP GQSPI) expects dummy in cycles won't work directly by using
len field because host driver doesn't know that len field of a particular t=
ransfer
includes dummy bytes or not (and also number of dummy bytes included in len
field). In such cases driver use this dummy field to identify the number of=
 dummy
cycles and based on that it will send the required number of dummy cycles (=
which
i did in the second patch).

Regards
Sai Krishna


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
