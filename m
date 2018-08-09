From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller documentation
Date: Thu, 9 Aug 2018 11:03:11 +0800
Message-ID: <CAMz4kuKwfBB8-8o5s8FQadFSFiD8KU=qNZYQjCWOfc-QpuVRSw@mail.gmail.com>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <20180807134121.GA7958@sirena.org.uk> <CAMz4kuJsyKv_fvrqRR3pdfKsLVy53Uj0KX+m_9jLxpcVcMvs9g@mail.gmail.com>
 <20180808095025.GB9346@sirena.org.uk> <CAMz4kuKZHxYiJaMHnqdAGth8XkfGnq3-Tsfc59cGjsHQHZaY7A@mail.gmail.com>
 <20180808105451.GE9346@sirena.org.uk> <1533754621.2283.270.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "lanqing.liu@spreadtrum.com" <lanqing.liu@spreadtrum.com>
To: Trent Piepho <tpiepho@impinj.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533754621.2283.270.camel@impinj.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Trent,

On 9 August 2018 at 02:57, Trent Piepho <tpiepho@impinj.com> wrote:
> On Wed, 2018-08-08 at 11:54 +0100, Mark Brown wrote:
>> On Wed, Aug 08, 2018 at 06:35:28PM +0800, Baolin Wang wrote:
>> > On 8 August 2018 at 17:50, Mark Brown <broonie@kernel.org> wrote:
>> > > Right, I don't think we added this yet (if we did I can't see
>> > > it).  I'd
>> > > add a new field to spi_transfer for this, then other controllers
>> > > with
>> > > the same support can implement it as well and drivers can start
>> > > using
>> > > it too.
>> > OK. So I will name the new filed as 'word_delay', is it OK for you?
>>
>> Sounds good, yes.
>
> Should it be in =C2=B5s like the existing iter-transfer delay?  I think
> perhaps units of cycles of the SPI clock make more sense?

Since some SPI controllers just want some interval values (neither =C2=B5s
unit nor cycles unit ) set into hardware, and the hardware will
convert to the correct delay time automatically. So I did not force
'word_delay' unit as =C2=B5s or cycle, and just let the slave devices
decide the unit which depends on the SPI hardware requirement.

--=20
Baolin Wang
Best Regards
