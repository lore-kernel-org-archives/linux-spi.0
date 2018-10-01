From: Hieu Tran Dang <dangtranhieu2012@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: fsl-lpspi: Option to allow stalling
Date: Mon, 1 Oct 2018 08:12:42 +0700
Message-ID: <CAAObPoFfhJZpr_iwcmub2zndTV4GK5byV0DFBybeqA_vB8mbQQ@mail.gmail.com>
References: <20180925203701.13605-1-dangtranhieu2012@gmail.com>
 <20180925203701.13605-2-dangtranhieu2012@gmail.com> <CABGGiszY6+UDwzfuS6ob0C1zcGL4DfhcZ_iYjUGSXwWcbjPYRg@mail.gmail.com>
 <CAAObPoHOEYrDj8uoFK-gW8jvy8i-vtRhTkEEm5aVNn8ucLxRMg@mail.gmail.com> <20180927224723.GF20825@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: robh@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180927224723.GF20825@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Agree. I will create new patch which will just allow stalling by default.

V=C3=A0o Th 6, 28 thg 9, 2018 v=C3=A0o l=C3=BAc 05:47 Mark Brown <broonie@k=
ernel.org> =C4=91=C3=A3 vi=E1=BA=BFt:
>
> On Wed, Sep 26, 2018 at 09:37:39PM +0700, =C4=90=E1=BA=B7ng Tr=E1=BA=A7n =
Hi=E1=BA=BFu wrote:
>
> > Default value of the register is to allow stalling (NOSTALL bit not
> > set) but the spi-fsl-lpspi driver defaults to setting the NOSTALL bit
> > in CFGR1. To me, it's more logical to leave the NOSTALL bit off with
> > fsl,nostall binding to set the bit but as I am not sure if there are
> > other drivers depending on the NOSTALL bit being set and not wanting
> > to break other drivers hence introduction of this binding to keep the
> > current default behavior.
>
> I can't see a situation where you'd actively want to report an error
> rather than stall, stalling allows us to handle things gracefully by
> restarting things.  Even if it's a timeout situation it sounds like we
> can unblock by reading/writing the stalled FIFO, and normally you'd be
> resetting the entire IP anyway.  I'd imagine the driver is this way
> either through an oversight or because there's some bug on some silicon
> which means that stalling breaks.
>
> Probably best to just always enable stalling unless I'm misreading
> things, if it is silicon bugs on some versions then either a whitelist
> or blacklist of SoCs to enable on (depending on how common the bug is)
> would be the way forwards - that way SoCs where it works get the benefit.
