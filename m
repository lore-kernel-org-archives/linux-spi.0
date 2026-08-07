Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C93A6F09
	for <linux-spi@vger.kernel.org>; Fri,  7 Aug 2026 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119767; cv=none; b=eomRT5qP4KwNS6LTkrOskSgQf/VYgg0oSECEuXlyT6PDW83MJEpHULLuI1Khvc5KCYhSb348hwN0QxGCUUQ0rlbZH1gaUY/ZNzR0fArO7jZVLVhznxV4/L3rHqt6E82e8jVpTCCb2BetR7v71H2GBwRn2ZZnJ4iBLXF0fxZtHvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119767; c=relaxed/simple;
	bh=nToylCqIVIRRoxvTuxCXuldsnYcCe1mc1KPvO0JTz7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxlJLaVsT5FIFoceSKRNmgsqWgxPrfA5Ijh+5mcjjW+OY3wrcXKy1glenaSTjidS+qOkCD+j1EgmH/WA/UAICzMDpINWAsSXYEinAHyMZwxnAfItBHj+RuVlGFf6BFlVfmQgbb2lwy7JPMJ/EnoFT1GmMNwrSXY+FGrOhxm1GbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EOfy6PaD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LgO6RbTF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EOfy6PaD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LgO6RbTF"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677FRcfB1021585
	for <linux-spi@vger.kernel.org>; Fri, 7 Aug 2026 16:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=V68gN1dWbWurMRqZ99HneGYh
	SLp2VJDyk+qChxkgrt0=; b=EOfy6PaDUH9ulR8dSqFB/RCwpIgodTYBB8sTmLTc
	uQhI7FdlEt+ZQubLmOJpeeeYhvwEzr48I+5SCVVGovGdBToIM4hZuUYlxmJgVxjy
	p9sRuh3JZX7O2xyo3dXzB/4OAVuAYaxsfWyiZaalrLxr29TorYugDGS3AZY3FIs4
	Htq6O52nHzginr0hIguIuDDxRyJjN5vRFvj06Q2OdIgC25onA2108fb0di6XW82Z
	TCtSDZH+06ognT1K8AcTXty3t03v+O/b4pQpq8dpLp5cklsDBiDj9oJttjufJObY
	vV86qvLvBq5xwFJK5r0todO7Vh2+I852J7TCUJSM66qRbg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwhk3gc5x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 07 Aug 2026 16:22:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so5185906a91.1
        for <linux-spi@vger.kernel.org>; Fri, 07 Aug 2026 09:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786119765; x=1786724565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V68gN1dWbWurMRqZ99HneGYhSLp2VJDyk+qChxkgrt0=;
        b=LgO6RbTFe4Isu0HQ4EupXhyhx8Ve8TP/EmmwhmN0ctKEsBzk2M1AU55bT2fXjUsFhU
         1Xs85zCTDUI8GxkTKm63urbnLnV/9zJDqGE34/T9IR0viuMdpfdh47nw+uQHWWBSyYBB
         reHwPE8VSaW5fzWDGuOwhhUoMtrqPanzYsc0dgDqKWbIVdcLfPjTk7K/YSDPwl6UWxiK
         5dVOxH8O2f7S+ZlYIgwAe5SYWMMaM4/d4NI2auPHiMO7wVS29dkuY3IWz3E50jR7Q8JF
         5Kldgg3u7SnhFEPxEdPA0nrLHgvJgBypCLE+ez/pMKqsxog8MFOk0R6TgMmDo/O2oa0n
         B/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786119765; x=1786724565;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V68gN1dWbWurMRqZ99HneGYhSLp2VJDyk+qChxkgrt0=;
        b=a6u14wPbDFfi8qGvuNgKVG2KgdMlbQL6DvEiFfSFJ91+b7FAAlrP97kqod4ojvY3Ac
         HaS1o0cS5rxrJkREv9XkUZowiKMbbTO+wA184X6Vog+uM+RZXnHgXuDhKDILbVOQwfYj
         dayaqagHKNiCpCmeaLQ53H7QD+0YMBEw8RUXBu3DPlmi4Ar60xWIuH1T50A5TUn8K5G3
         PlD4Mb7g3nUuCe7N2GWTdQWKFn7mscIGhSrdxTXKCQuC9h/1q8kjyUG7upvepYp6UDeW
         ucdW3BwFSY6sNg2tUT7/CPZCkvdlZG7HaHSFWDMV+FHzWnqhMRPVFyMgigiCzzHVnNLs
         aq8A==
X-Gm-Message-State: AOJu0YzrwwjP6zg8BtmzmJU0xhnjfCmfvzZCcXDA7GpyvGQ+x/zc0ZSA
	yy01mgnmKTv+VuE8UvmsuA8/nnzEMlXjnsNlKK5MOOlr71tbh5ZisOlY9YEVjLyimKf+/qHgK+N
	ALRO/7sLjo2IEHEPNzTJG0rae/77O60/8DC1af8esM9kXUi0ldq4K+tePbtGBXbPNuEZAn3A=
X-Gm-Gg: AR+sD12pGO6lks7OA3NISvyRNUTXbT03l2PcVtR5fi1bChVGiU0tk9VXR2b7ntOzdEJ
	h6cMrrzyW6K7rJbDK04Fc+vO9+f5aQodVREiVfl4n98++xZRkLgU5Wd1m0hft3N1+1Si6mGTe6b
	OueGT/R7fja3WIhJbFtqcpKRiW1RzRrIYNvw+MIlTaHjxeR9xr++DFprxK11U1HOdjrXh8tmUzz
	QiT0K3qhMHPHcYnoINxsr7GrVN2azytysbbFNDRSJya4Qv18/M15n1B9BcH8vTh5M+5U74ZVHnj
	2Ht1VtWt/j8L0AWtF4oaxMzkWe9JOKdpOFkYR0QZfzhaxB1mozmUVCdee1nzU2i8oQ11k5+D7LT
	XKmji4rcg9l5X3sl8JXpzdRd/sqzkgqVMKBx0iN6XwfC6AFU205i/92BUj0DcXphloMUujbQyyz
	FmgFjdUppSx2k=
X-Received: by 2002:a17:90b:1a91:b0:38f:1dc:672f with SMTP id 98e67ed59e1d1-39282501a75mr767411a91.18.1786119764085;
        Fri, 07 Aug 2026 09:22:44 -0700 (PDT)
X-Received: by 2002:a17:90b:1a91:b0:38f:1dc:672f with SMTP id 98e67ed59e1d1-39282501a75mr767342a91.18.1786119763638;
        Fri, 07 Aug 2026 09:22:43 -0700 (PDT)
Received: from hu-mdalam-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86d3fcsm9240408eec.4.2026.08.07.09.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:22:43 -0700 (PDT)
Date: Fri, 7 Aug 2026 21:52:38 +0530
From: Md Sadre Alam <md.alam@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Md Sadre Alam <mdalam@qti.qualcomm.com>
Subject: Re: [PATCH 2/3] spi: spi-qpic-snand: add quad mode support
Message-ID: <anYGTr31beVXVBoJ@hu-mdalam-blr.qualcomm.com>
References: <20260716-quad-v1-0-636f74da17e1@qti.qualcomm.com>
 <20260716-quad-v1-2-636f74da17e1@qti.qualcomm.com>
 <a9595e1c-fa08-4d1d-a13b-3ea89a27519a@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9595e1c-fa08-4d1d-a13b-3ea89a27519a@sirena.org.uk>
X-Authority-Analysis: v=2.4 cv=RKaD2Yi+ c=1 sm=1 tr=0 ts=6a760655 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IgOFGxCipB3eCMMLPuYA:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEyNyBTYWx0ZWRfXyS0PfpauI10h
 qoJLjqPpECO6ZfbxvNmqr54q8x7SvBq+2whVBTt4bJakW/ozgOWwnFqaaEdNPG//GtlX16aJiwq
 iZS4K7Z8fWPgx+f2BF5tAGuSARvcRqY=
X-Proofpoint-ORIG-GUID: 5kI8E6Tn_TBbblRj6_opHh-V0aJwWHGj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEyNyBTYWx0ZWRfX1zLsDRE1t8bp
 KWJuJDkd1MXQ2TQ9VU8HoD1C6KlG+doPaIizX0OmZ1n0mYc6+tHFIXLXucbmZNO4+wQ1va0p6Tg
 osb4pELFZDmtn+zKJq00FqDqCH4orJXMj88/EOXkDQoR8a6lBKA3EO3uDSOAsXTu+4gEKYjGEEy
 9h8ewOoh5hWtuYLq0U9EktzFdvexXpg3yreBzc+uZKD45rEOXwAuTqRTKA1ubG2Xzb5YXu8eu/Y
 J8JFB3h2+y+LWxBbE/I7aBE1D2LVovM3hFrwnuvsQXtZ8Yrs/xz65i5kwtW8167rqneSkhVBJSi
 /sV2wXXf86Fm8LXtgfG/En+oLKNSuqzO3KMH//xbc71Q39XFDM+SkGITbvUNNcz9lxcxWyYL55a
 VwvXDXPAXi0mnziKiA7ysvziIf/qod67bhDdT6wu5wPgv0hx4fG/szpWyhi+k6OZQeW7dQmJg1Z
 s6VXXAfLQ2ZZwsyvUsg==
X-Proofpoint-GUID: 5kI8E6Tn_TBbblRj6_opHh-V0aJwWHGj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070127

On Wed, Jul 29, 2026 at 03:46:43PM +0100, Mark Brown wrote:
> On Thu, Jul 16, 2026 at 10:57:46AM +0530, Md Sadre Alam wrote:
> > Add support for quad (x4) transfer mode in the QPIC SPI NAND driver.
> > The controller supports both single (x1) and quad (x4) SPI transfers,
> > but the driver currently operates only in x1 mode.
> 
> > @@ -1025,12 +1040,16 @@ static int qcom_spi_cmd_mapping(struct qcom_nand_controller *snandc, u32 opcode,
> >  		*cmd = SPINAND_WRITE_EN;
> >  		break;
> >  	case SPINAND_PROGRAM_EXECUTE:
> > -		*cmd = (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
> > -				SPI_WP | SPI_HOLD | OP_PROGRAM_PAGE);
> > +		if (snandc->qspi->quad_mode)
> > +			*cmd = (PAGE_ACC | LAST_PAGE | transfer_mode |
> > +					SPI_WP | SPI_HOLD | OP_PROGRAM_PAGE);
> 
> This succeeds but does not initialize cmd, previously we'd accept and
> use x1.
> 
> > @@ -1042,6 +1061,15 @@ static int qcom_spi_cmd_mapping(struct qcom_nand_controller *snandc, u32 opcode,
> >  static int qcom_spi_read_page(struct qcom_nand_controller *snandc,
> >  			      const struct spi_mem_op *op)
> >  {
> > +	int ret;
> > +	u32 cmd;
> > +	/* Call mapping once again to update the quad mode based on
> > +	 * buswidth
> > +	 */
> > +	ret = qcom_spi_cmd_mapping(snandc, op, &cmd);
> > +	if (ret < 0)
> > +		return ret;
> > +
> >  	if (snandc->qspi->page_rw && snandc->qspi->raw_rw)
> >  		return qcom_spi_read_page_raw(snandc, op);
> 
> We never reference cmd in the rest of the function, either we didn't
> need to do the mapping or there's a missing update.

I have addressed both the comments in revision 2 [1]. Please review.

Thanks
Alam

1 - https://lore.kernel.org/linux-arm-msm/20260807-quad-v2-0-8ec821e2f22b@oss.qualcomm.com/
