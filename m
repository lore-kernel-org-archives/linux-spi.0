From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi/spi-altera: Allow to explicitely override bus number
 via dts
Date: Wed, 1 Feb 2012 10:59:20 -0700
Message-ID: <CACxGe6sZst_rt4AJWt23Zc9QNqT29KYFFoVk5AxooM=MG5DRiw@mail.gmail.com>
References: <1328025246-23450-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Frederic Lambert <frdrc66-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
To: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1328025246-23450-1-git-send-email-tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jan 31, 2012 at 8:54 AM, Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org> wrote:
> From: Frederic Lambert <frdrc66-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Until now we let the code in spi.c assign us the bus number if the platfo=
rm
> device didn't specify its id. This patch adds the possibility to explicit=
ely
> specify the bus number via device tree.
>
> Signed-off-by: Frederic Lambert <frdrc66-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
> ---
> diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
> index 4813a63..d5bf52b 100644
> --- a/drivers/spi/spi-altera.c
> +++ b/drivers/spi/spi-altera.c
> @@ -226,6 +226,15 @@ static int __devinit altera_spi_probe(struct platfor=
m_device *pdev)
> =A0 =A0 =A0 =A0if (!master)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>
> + =A0 =A0 =A0 /* bus_num is dynamically assigned when undefined (see spi.=
c) =A0*/
> + =A0 =A0 =A0 /* look for a DTS entry to override this */
> + =A0 =A0 =A0 if (pdev->id =3D=3D -1 && pdev->dev.of_node !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 tmp;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_property_read_u32(pdev->dev.of_node,=
 "bus-number", &tmp) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev->id =3D tmp;

BTW, it is absolutely illegal for device drivers to modify the
pdev->id field.  Once a device is registered, the id and name cannot
be changed.

g.
