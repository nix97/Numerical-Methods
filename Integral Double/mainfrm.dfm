object FrmDataVis: TFrmDataVis
  Left = 453
  Top = 63
  Width = 861
  Height = 612
  Caption = 'Graphic of Equation F(x,y)'
  Color = clBtnFace
  Constraints.MinHeight = 600
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 845
    Height = 37
    Align = alTop
    TabOrder = 0
    DesignSize = (
      845
      37)
    object BButExit: TBitBtn
      Left = 694
      Top = 4
      Width = 152
      Height = 29
      Anchors = [akTop, akRight]
      Caption = 'Exit'
      TabOrder = 0
      OnClick = BButExitClick
      Glyph.Data = {
        72010000424D7201000000000000760000002800000015000000150000000100
        040000000000FC0000000000000000000000100000001000000063311800CE63
        3100CE6B3900D684520084848400E7A58400EFBDAD00EFC6B500F7D6C600F7E7
        D600FFEFE700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BBBBBBBBBBBB
        BBBBBBBBB000BBBBBBBBBBBBBBBBBBBBB000BBBBBBBBBBBBBBBBBBBBB900BBBB
        BBBBBBBBBBBBBBBBB600BBBBBB14BBBBBBBBBBBBB300BBBBB2104BBBBBBBBBBB
        BB03BBBB611104BBBBBBBBBBB000BBB51111104BBBBBBBBBB000BBB211121104
        BBBBBBBBB900BBB6112863104BBBBBBBB900BBB9315B761104BBBBBBB300BBBB
        66BBBA61104BBBBBB900BBBB8BBBBBA61104BBBBB000BBBBBBBBBBB893104BBB
        B000BBBBBBBBBBBB7A310BBBB900BBBBBBBBBBBBBBA625BBB600BBBBBBBBBBBB
        BBB86BBBB000BBBBBBBBBBBBBBBBBBBBBC00BBBBBBBBBBBBBBBBBBBBB100BBBB
        BBBBBBBBBBBBBBBBB000BBBBBBBBBBBBBBBBBBBBB000}
    end
    object BButExecute: TBitBtn
      Left = 537
      Top = 4
      Width = 152
      Height = 29
      Anchors = [akTop, akRight]
      Caption = 'Recalculation'
      Enabled = False
      TabOrder = 1
      OnClick = BButExecuteClick
      Glyph.Data = {
        96090000424D9609000000000000360000002800000028000000140000000100
        1800000000006009000000000000000000000000000000000000C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C9CCD0707272D0D7DCC6C6C6C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0BCBCBCE9E9E9F0F0F0B4B4B4BDBDBDC0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C3C6C1B7B0C54800361D0CA3B3BDD1D2D2C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C2C2C2B7B7
        B7616161E0E0E0FFFFFFC4C4C4B8B8B8BFBFBFC0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0BFCCD4C1774CC45C1C
        D967216E250058666FD7DCE0C3C3C3C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8C8C8898989A3A3A36969699D
        9D9DFFFFFFE5E5E5B4B4B4BEBEBEC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C2C3BFC4C8C04E07C25F23C26024CF6625B84D
        0C32261EB7C5CDCDCDCEC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C1C1C1C2C2C2666666FFFFFFDBDBDB7F7F7F727272F6F6F6
        FFFFFFBDBDBDBABABAC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0BFC9CFC18867C25614C25614C25F23C26024D26320DA5C0E5715006F
        7A80CDCECEC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C6C6C69A9A9A8585857070707D7D7D7878787070705D5D5DB1B1B1FFFFFFDCDC
        DCBBBBBBC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C1BFCCD6C1
        4900C15D1FBFAFA5C1530ECA5F1D524741D2B5A5D19A77985A36929596C5C5C5
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C9C9C97070707C7C
        7CAEAEAEA1A1A18A8A8AEEEEEEBFBFBF9090909C9C9CE1E1E1BCBCBCC0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C3C9CCC18E6EBF8867BFD0DBBFCFD8
        C18B6CCA5A1686330094ACBBC7CED3C5CCD0C5C5C5C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C2C2C2989898979797CACACACACACA909090C2
        C2C2858585FFFFFFBCBCBCC2C2C2BCBCBCC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C3C3C3A6B1B8C1CED7CCDBE4CBCFD2CACCCCC4D3DCC15614D866
        20402210D4DBE0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0BEBEBED0D0D0F3F3F3DBDBDBBEBEBEB7B7B7C0C0C07C7C7CA6A6A6D4D4D4
        F3F3F3B7B7B7C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C3CE
        D5AD4F176B2200653A2264574F65747DA2B7C2CFB8ABC65815C1531058666DCF
        D0D1C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C6C6C6898989
        A5A5A5CFCFCFF7F7F7FFFFFFFFFFFFC0C0C0BABABA6C6C6CFFFFFFC7C7C7BDBD
        BDC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C7CBC2997FCC5B15CD
        6220CF601BD35A12903500592B10BC5C21D16625652300B5C3CCC3C3C3C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C4C4C4A0A0A08D8D8D6E6E6E6E6E
        6E6363638C8C8CC6C6C6757575C8C8C89F9F9FFFFFFFB4B4B4BFBFBFC0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C1BFCDD4C0520EC35F22C25C1F7B553C
        D3783FCC5209C45612C25919D962193C322DD7DBDDC0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C7C7C76E6E6EC5C5C56F6F6FCDCDCD82828269
        6969727272A0A0A06C6C6CF8F8F8E3E3E3BABABAC0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0BFC9CFC18966C25818CE65245E2606B4D0E2C3CDD2BFA5
        94C1845EC66223A430006D7980C9C9C9C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C6C6C6919191C6C6C68A8A8AB3B3B3FFFFFFBBBBBBACACAC939393
        7A7A7A727272FFFFFFBBBBBBC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C2C3BFC3C6C04E08C26023DA651E382B23D7DDE1C0C5C8BFC9CFBFD0D9C7
        C1BEAEA39CC2C4C4C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C1C1C1
        C2C2C2656565FFFFFF525252F4F4F4E9E9E9BCBCBCC6C6C6CACACAB8B8B8B9B9
        B9BFBFBFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0BFCDD4C1
        774AC25A1BC66225B24A0964737DCECFCFC0C0C0C0C0C0C0C2C3C2C4C4C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C8C8C8838383D1D1
        D1CECECE656565FFFFFFC3C3C3BDBDBDC0C0C0C1C1C1BFBFBFC0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C3C6BFB6AFC2500AC26024
        D166255F2000B6C4CDC3C3C3C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C2C2C2B6B6B66E6E6EFFFFFF7B7B7BA8
        A8A8FFFFFFB3B3B3BFBFBFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0BFCED8C16730C25C1EC26024DA651E382B
        23D7DCDFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C9C9C9737373E2E2E2FFFFFF5B5B5BF4F4F4E9E9E9
        B9B9B9C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C5C9BFA495C24A01C25512C65713B23D005D6569CACBCBC0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C4C4C4ABABAB6F6F6F9292927E7E7E6E6E6EFFFFFFBFBFBFBFBFBFC0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C7CCBFA899BFADA0BFADA0C6AE9EB7ACA7C2C4C5C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C4C4
        C4AEAEAEAEAEAEB2B2B2ADADADB7B7B7BFBFBFC0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
      NumGlyphs = 2
    end
    object CBoxAutoCalc: TCheckBox
      Left = 8
      Top = 16
      Width = 473
      Height = 17
      Caption = 
        'automatic recalculation of the interpolation after any data chan' +
        'ge '
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 37
    Width = 169
    Height = 536
    Align = alLeft
    TabOrder = 1
    object Label1: TLabel
      Left = 7
      Top = 406
      Width = 95
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = '# Neighbors'
    end
    object LblSmooth: TLabel
      Left = 7
      Top = 432
      Width = 95
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Smoothing'
    end
    object Label3: TLabel
      Left = 7
      Top = 380
      Width = 95
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Resolution'
    end
    object GroupBox3: TGroupBox
      Left = 9
      Top = 7
      Width = 152
      Height = 199
      Caption = 'Colors'
      TabOrder = 0
      object SpeedButton1: TSpeedButton
        Left = 122
        Top = 22
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = SpeedButton1Click
      end
      object SpeedButton2: TSpeedButton
        Left = 122
        Top = 48
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = SpeedButton2Click
      end
      object SpeedButton3: TSpeedButton
        Left = 122
        Top = 74
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = SpeedButton3Click
      end
      object SBLoadUsercolor: TSpeedButton
        Left = 9
        Top = 108
        Width = 136
        Height = 21
        Caption = 'Load Colors'
        OnClick = SBLoadUsercolorClick
      end
      object SBSaveUserColor: TSpeedButton
        Left = 9
        Top = 128
        Width = 136
        Height = 21
        Caption = 'Store Colors'
        OnClick = SBSaveUserColorClick
      end
      object SBGrayScale: TSpeedButton
        Left = 9
        Top = 148
        Width = 136
        Height = 21
        Caption = 'Gray Scale Colors'
        OnClick = SBGrayScaleClick
      end
      object SBStandardColors: TSpeedButton
        Left = 9
        Top = 168
        Width = 136
        Height = 21
        Caption = 'Default Colors'
        OnClick = SBStandardColorsClick
      end
      object CSHigh: TColSel
        Left = 9
        Top = 22
        Width = 112
        Height = 22
        ColorBarWidth = 30
        Enabled = True
        NumColors = 20
        SelColor = 8421631
        TabOrder = 0
        OnChange = NewCalcNeededAfterClick
      end
      object CSMid: TColSel
        Left = 9
        Top = 48
        Width = 112
        Height = 22
        ColorBarWidth = 30
        Enabled = True
        NumColors = 20
        SelColor = 8454016
        TabOrder = 1
        OnClick = NewCalcNeededAfterClick
      end
      object CSLow: TColSel
        Left = 9
        Top = 74
        Width = 112
        Height = 22
        ColorBarWidth = 30
        Enabled = True
        NumColors = 20
        SelColor = 16744576
        TabOrder = 2
        OnClick = NewCalcNeededAfterClick
      end
    end
    object NIOSmooth: TNumIO
      Left = 106
      Top = 430
      Width = 55
      Height = 24
      Beep = False
      DecPlaceSep = dsDot
      FixPointDecPlaces = 2
      InputFormat = itDynamic
      RangeHigh = 10.000000000000000000
      RangeLow = -1.7E308
      TabOrder = 1
      Text = '1.5'
      OnChange = NewCalcNeededAfterClick
    end
    object NIONumNb: TNumIO
      Left = 106
      Top = 404
      Width = 55
      Height = 24
      Beep = False
      DecPlaceSep = dsDot
      FixPointDecPlaces = 2
      InputFormat = itInt
      RangeHigh = 1000.000000000000000000
      RangeLow = -1.7E308
      TabOrder = 2
      Text = '5'
      OnChange = NewCalcNeededAfterClick
    end
    object RGWeighting: TRadioGroup
      Left = 9
      Top = 283
      Width = 152
      Height = 80
      Caption = 'Weighting'
      ItemIndex = 0
      Items.Strings = (
        'Gaussian'
        'Average'
        'Median')
      TabOrder = 3
      OnClick = RGWeightingClick
    end
    object NIOResol: TNumIO
      Left = 106
      Top = 378
      Width = 55
      Height = 24
      Beep = False
      DecPlaceSep = dsDot
      FixPointDecPlaces = 2
      InputFormat = itDynamic
      RangeHigh = 250.000000000000000000
      RangeLow = 1.000000000000000000
      TabOrder = 4
      Text = '30'
      OnChange = NewCalcNeededAfterClick
    end
    object RGColorScale: TRadioGroup
      Left = 9
      Top = 214
      Width = 152
      Height = 60
      Caption = 'Color Coding'
      ItemIndex = 0
      Items.Strings = (
        'Min/Max'
        'Interquartil Distance')
      TabOrder = 5
      OnClick = NewCalcNeededAfterClick
    end
  end
  object Panel6: TPanel
    Left = 169
    Top = 37
    Width = 676
    Height = 536
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 676
      Height = 461
      ActivePage = TSData
      Align = alClient
      TabOrder = 0
      object TSData: TTabSheet
        Caption = 'Data Input'
        object TEData: TNTabEd
          Left = 0
          Top = 0
          Width = 297
          Height = 430
          Align = alLeft
          AutoAdvance = True
          AutoAdvanceDir = orVert
          AttribRowVisible = False
          AttribColVisible = False
          BlockInternalPopup = False
          CommentEditingAllowed = True
          ColorBackground = clWindow
          ColorFixed = clBtnFace
          ColorNormal = 8192
          ColorSelected = clWhite
          ColorMarkedA = clRed
          ColorMarkedB = clBlue
          ColorMarkedBoth = 13369531
          DefaultColWidth = 64
          PopupMenu = PopMenEmptyDummy
          BoldMarks = True
          BoldSelHeads = True
          ClipboardUseFullPrec = True
          NrOfColumns = 3
          NrOfRows = 1
          NumWidth = 1
          DataReadOnly = False
          OptimizeRowHeight = False
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goThumbTracking]
          TopRow = 1
          OnChange = TEDataChange
          ColWidths = (
            80
            64
            64
            64)
          RowHeights = (
            24
            24)
        end
        object BButLoadData: TBitBtn
          Left = 304
          Top = 32
          Width = 217
          Height = 33
          Caption = 'Load Data from Disk'
          TabOrder = 1
          OnClick = BButLoadDataClick
        end
        object CBoxEditDataAllowed: TCheckBox
          Left = 304
          Top = 8
          Width = 305
          Height = 17
          Caption = 'allow manual editing of the data'
          TabOrder = 2
          OnClick = CBoxEditDataAllowedClick
        end
        object Button1: TButton
          Left = 304
          Top = 72
          Width = 75
          Height = 25
          Caption = 'Clear'
          TabOrder = 3
          OnClick = Button1Click
        end
      end
      object TSColorMap: TTabSheet
        Caption = 'Color Map'
        ImageIndex = 1
        object Label8: TLabel
          Left = 32
          Top = 32
          Width = 192
          Height = 25
          Caption = 'Recalculation required'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object RCCPlot: TRChart
          Left = 0
          Top = 0
          Width = 524
          Height = 430
          Align = alClient
          AllocSize = 1000
          AutoRedraw = True
          MarginRight = 14
          MarginTop = 20
          MarginBottom = 40
          RRim = 14
          TRim = 20
          BRim = 40
          BackGroundImg.IncludePath = False
          BackGroundImg.FillMode = bfStretch
          BackGroundImg.AreaMode = bamNone
          BackGroundImg.AreaColor = 14540253
          BackGroundImg.AreaLeft = -1.000000000000000000
          BackGroundImg.AreaRight = 1.000000000000000000
          BackGroundImg.AreaTop = 1.000000000000000000
          BackGroundImg.AreaBottom = -1.000000000000000000
          ClassDefault = 0
          GridStyle = gsNone
          Isometric = False
          JointLayers.L01xControlledBy = 1
          JointLayers.L01yControlledBy = 1
          JointLayers.L02xControlledBy = 2
          JointLayers.L02yControlledBy = 2
          CaptionPosX = 0
          CaptionPosY = -16
          CaptionAlignment = taRightJustify
          CaptionAnchorHoriz = cahChartRight
          CaptionAnchorVert = cavChartTop
          CrossHair1.Color = clBlack
          CrossHair1.Layer = 1
          CrossHair1.Mode = chOff
          CrossHair1.LineType = psSolid
          CrossHair1.LineWid = 1
          CrossHair2.Color = clBlack
          CrossHair2.Layer = 2
          CrossHair2.Mode = chOff
          CrossHair2.LineType = psSolid
          CrossHair2.LineWid = 1
          CrossHair3.Color = clBlack
          CrossHair3.Layer = 2
          CrossHair3.Mode = chOff
          CrossHair3.LineType = psSolid
          CrossHair3.LineWid = 1
          CrossHair4.Color = clBlack
          CrossHair4.Layer = 2
          CrossHair4.Mode = chOff
          CrossHair4.LineType = psSolid
          CrossHair4.LineWid = 1
          MouseAction = maNone
          MouseCursorFixed = True
          Scale1X.CaptionPosX = 0
          Scale1X.CaptionPosY = 22
          Scale1X.CaptionAlignment = taCenter
          Scale1X.CaptionAnchor = uaSclCenter
          Scale1X.ColorScale = clBlack
          Scale1X.DateFormat.TimeFormat = tfHHMMSS
          Scale1X.DateFormat.DateSeparator = '-'
          Scale1X.DateFormat.TimeSeparator = ':'
          Scale1X.DateFormat.YearLength = ylYYYY
          Scale1X.DateFormat.MonthName = True
          Scale1X.DateFormat.DateOrder = doDDMMYY
          Scale1X.DateFormat.DateForTime = dtOnePerDay
          Scale1X.DecPlaces = -2
          Scale1X.Font.Charset = DEFAULT_CHARSET
          Scale1X.Font.Color = clWindowText
          Scale1X.Font.Height = -13
          Scale1X.Font.Name = 'MS Sans Serif'
          Scale1X.Font.Style = []
          Scale1X.Logarithmic = False
          Scale1X.LabelType = ftNum
          Scale1X.MinTicks = 3
          Scale1X.MinRange = 0.000000000100000000
          Scale1X.RangeHigh = 1.000000000000000000
          Scale1X.ShortTicks = True
          Scale1X.ScalePos = 0
          Scale1X.Visible = True
          Scale1X.ScaleLocation = slBottom
          Scale1Y.CaptionPosX = 0
          Scale1Y.CaptionPosY = -16
          Scale1Y.CaptionAlignment = taLeftJustify
          Scale1Y.CaptionAnchor = uaSclTopLft
          Scale1Y.ColorScale = clBlack
          Scale1Y.DateFormat.TimeFormat = tfHHMMSS
          Scale1Y.DateFormat.DateSeparator = '-'
          Scale1Y.DateFormat.TimeSeparator = ':'
          Scale1Y.DateFormat.YearLength = ylYYYY
          Scale1Y.DateFormat.MonthName = True
          Scale1Y.DateFormat.DateOrder = doDDMMYY
          Scale1Y.DateFormat.DateForTime = dtOnePerDay
          Scale1Y.DecPlaces = -2
          Scale1Y.Font.Charset = DEFAULT_CHARSET
          Scale1Y.Font.Color = clWindowText
          Scale1Y.Font.Height = -13
          Scale1Y.Font.Name = 'MS Sans Serif'
          Scale1Y.Font.Style = []
          Scale1Y.Logarithmic = False
          Scale1Y.LabelType = ftNum
          Scale1Y.MinTicks = 3
          Scale1Y.MinRange = 0.000000000100000000
          Scale1Y.RangeHigh = 1.000000000000000000
          Scale1Y.ShortTicks = True
          Scale1Y.ScalePos = 0
          Scale1Y.Visible = True
          Scale1Y.ScaleLocation = slLeft
          Scale2X.CaptionPosX = 10
          Scale2X.CaptionPosY = 100
          Scale2X.CaptionAlignment = taCenter
          Scale2X.CaptionAnchor = uaSclCenter
          Scale2X.ColorScale = clMaroon
          Scale2X.DateFormat.TimeFormat = tfHHMMSS
          Scale2X.DateFormat.DateSeparator = '-'
          Scale2X.DateFormat.TimeSeparator = ':'
          Scale2X.DateFormat.YearLength = ylYYYY
          Scale2X.DateFormat.MonthName = True
          Scale2X.DateFormat.DateOrder = doDDMMYY
          Scale2X.DateFormat.DateForTime = dtOnePerDay
          Scale2X.DecPlaces = -2
          Scale2X.Font.Charset = DEFAULT_CHARSET
          Scale2X.Font.Color = clWindowText
          Scale2X.Font.Height = -13
          Scale2X.Font.Name = 'MS Sans Serif'
          Scale2X.Font.Style = []
          Scale2X.Logarithmic = False
          Scale2X.LabelType = ftNum
          Scale2X.MinTicks = 3
          Scale2X.MinRange = 0.000000000100000000
          Scale2X.RangeHigh = 1.000000000000000000
          Scale2X.ShortTicks = True
          Scale2X.ScalePos = 0
          Scale2X.Visible = False
          Scale2X.ScaleLocation = slBottom
          Scale2Y.CaptionPosX = 10
          Scale2Y.CaptionPosY = 100
          Scale2Y.CaptionAlignment = taRightJustify
          Scale2Y.CaptionAnchor = uaSclTopLft
          Scale2Y.ColorScale = clMaroon
          Scale2Y.DateFormat.TimeFormat = tfHHMMSS
          Scale2Y.DateFormat.DateSeparator = '-'
          Scale2Y.DateFormat.TimeSeparator = ':'
          Scale2Y.DateFormat.YearLength = ylYYYY
          Scale2Y.DateFormat.MonthName = True
          Scale2Y.DateFormat.DateOrder = doDDMMYY
          Scale2Y.DateFormat.DateForTime = dtOnePerDay
          Scale2Y.DecPlaces = -2
          Scale2Y.Font.Charset = DEFAULT_CHARSET
          Scale2Y.Font.Color = clWindowText
          Scale2Y.Font.Height = -13
          Scale2Y.Font.Name = 'MS Sans Serif'
          Scale2Y.Font.Style = []
          Scale2Y.Logarithmic = False
          Scale2Y.LabelType = ftNum
          Scale2Y.MinTicks = 3
          Scale2Y.MinRange = 0.000000000100000000
          Scale2Y.RangeHigh = 1.000000000000000000
          Scale2Y.ShortTicks = True
          Scale2Y.ScalePos = 0
          Scale2Y.Visible = False
          Scale2Y.ScaleLocation = slLeft
          ShadowStyle = ssFlying
          ShadowColor = clGrayText
          ShadowBakColor = clBtnFace
          TextFontStyle = []
          TextBkStyle = tbClear
          TextBkColor = clWhite
          TextAlignment = taCenter
          OnMouseMoveInChart = RCCPlotMouseMoveInChart
        end
        object Panel2: TPanel
          Left = 524
          Top = 0
          Width = 144
          Height = 430
          Align = alRight
          BevelOuter = bvLowered
          TabOrder = 0
          object NLXCoord: TNumLab
            Left = 3
            Top = 28
            Width = 140
            Height = 22
            Hint = 'BF_click here to change variable'
            Alignment = taCenter
            ColorLabBakG = clSilver
            ColorLabText = clBlack
            ColorOutBakG = clBtnFace
            ColorOutText = clBlack
            ColorScheme = csBWG
            Comma = False
            DisplayType = dtFloat
            DTFormat = 'mmm-dd, yyyy'
            Empty = False
            ForcePlusSign = False
            FrameStyle = fsRaised
            LabelWidth = 60
            LeftSpace = 70
            LeftText = 'X:'
            LeftTextAlignment = taRightJustify
            OverflowIndicator = '*********'
            ParentShowHint = False
            Precision = 5
            RightTextAlignment = taLeftJustify
            ShowHint = True
            StateText = 'undefined'
            Transparent = False
          end
          object NLYCoord: TNumLab
            Left = 3
            Top = 71
            Width = 140
            Height = 23
            Hint = 'BF_click here to change variable'
            Alignment = taCenter
            ColorLabBakG = clSilver
            ColorLabText = clBlack
            ColorOutBakG = clBtnFace
            ColorOutText = clBlack
            ColorScheme = csBWG
            Comma = False
            DisplayType = dtFloat
            DTFormat = 'mmm-dd, yyyy'
            Empty = False
            ForcePlusSign = False
            FrameStyle = fsRaised
            LabelWidth = 60
            LeftSpace = 70
            LeftText = 'Y:'
            LeftTextAlignment = taRightJustify
            OverflowIndicator = '*********'
            ParentShowHint = False
            Precision = 5
            RightTextAlignment = taLeftJustify
            ShowHint = True
            StateText = 'undefined'
            Transparent = False
          end
          object NLZCoord: TNumLab
            Left = 3
            Top = 116
            Width = 140
            Height = 22
            Hint = 'BF_click here to change variable'
            Alignment = taCenter
            ColorLabBakG = clSilver
            ColorLabText = clBlack
            ColorOutBakG = clBtnFace
            ColorOutText = clBlack
            ColorScheme = csBWG
            Comma = False
            DisplayType = dtFloat
            DTFormat = 'mmm-dd, yyyy'
            Empty = False
            ForcePlusSign = False
            FrameStyle = fsRaised
            LabelWidth = 60
            LeftSpace = 70
            LeftText = 'Z:'
            LeftTextAlignment = taRightJustify
            OverflowIndicator = '*********'
            ParentShowHint = False
            Precision = 5
            RightTextAlignment = taLeftJustify
            ShowHint = True
            StateText = 'undefined'
            Transparent = False
          end
          object Label4: TLabel
            Left = 10
            Top = 98
            Width = 123
            Height = 16
            Caption = 'Z Axis (Color Coded)'
          end
          object Label5: TLabel
            Left = 10
            Top = 54
            Width = 37
            Height = 16
            Caption = 'Y Axis'
          end
          object Label6: TLabel
            Left = 10
            Top = 10
            Width = 36
            Height = 16
            Caption = 'X Axis'
          end
          object CBoxShowData: TCheckBox
            Left = 10
            Top = 143
            Width = 127
            Height = 21
            Caption = 'Show Data'
            Checked = True
            State = cbChecked
            TabOrder = 0
            OnClick = CBoxShowDataClick
          end
        end
      end
      object TS3DPlot: TTabSheet
        Caption = '3D Plot'
        ImageIndex = 2
        object Label7: TLabel
          Left = 32
          Top = 32
          Width = 192
          Height = 25
          Caption = 'Recalculation required'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Plot3D1: TPlot3D
          Left = 0
          Top = 0
          Width = 524
          Height = 430
          Cursor = crHandPoint
          Align = alClient
          AutoCenter = True
          PopupMenu = popMenPlot3D
          BoundBoxStyle = bbFaces
          CaptionX = 'X'
          CaptionY = 'Y'
          CaptionZ = 'Z'
          CentX = 262
          CentY = 215
          ColorFrame = clGray
          ColorBakGnd = clBtnFace
          ColorCodeAvg = False
          ColorCubeFrame = 4210752
          ColorCubeHidLin = clSilver
          ColorCubeFaceLow = 16247519
          ColorCubeFaceHigh = 16512238
          ColorXCoords = clRed
          ColorYCoords = clBlue
          ColorZCoords = clBlack
          ColorMesh = clMaroon
          ColorHigh = clYellow
          ColorMid = clWhite
          ColorLow = clFuchsia
          ColorScaleHigh = 0.200000000000000000
          ColorCodingMode = ccmThreeColors
          ColorScheme = csBWG
          DecPlaceX = 1
          DecPlaceY = 1
          DecPlaceZ = 2
          FrameStyle = fsNone
          LabDistX = 40
          LabDistY = 40
          LabDistZ = 20
          MeshVisible = True
          MeshKind = mkMesh
          Magnification = 1.000000000000000000
          MouseAction = maRotate
          MinTickX = 3
          MinTickY = 3
          MinTickZ = 3
          RangeXLow = -1.000000000000000000
          RangeYLow = -1.000000000000000000
          RangeZLow = -1.000000000000000000
          RangeXHigh = 1.000000000000000000
          RangeYHigh = 1.000000000000000000
          RangeZHigh = 1.000000000000000000
          ScaleFactX = 1.000000000000000000
          ScaleFactY = 1.000000000000000000
          ScaleFactZ = 1.000000000000000000
          ViewAngleX = 75.000000000000000000
          ViewAngleZ = 160.000000000000000000
          VisibleXCoords = True
          VisibleYCoords = True
          VisibleZCoords = True
          OnMouseAction = Plot3D1MouseAction
          OnBeforeRenderPolygon = Plot3D1BeforeRenderPolygon
          OnBeforeDrawScaleLabel = Plot3D1BeforeDrawScaleLabel
          OnMouseUp = Plot3D1MouseUp
        end
        object Panel4: TPanel
          Left = 524
          Top = 0
          Width = 144
          Height = 430
          Align = alRight
          BevelOuter = bvLowered
          TabOrder = 0
          DesignSize = (
            144
            430)
          object NLabZ: TNumLab
            Left = 8
            Top = 7
            Width = 133
            Height = 22
            Alignment = taCenter
            ColorLabBakG = clSilver
            ColorLabText = clBlack
            ColorOutBakG = clBtnFace
            ColorOutText = clBlack
            ColorScheme = csBWG
            Comma = False
            DisplayType = dtFixP
            DTFormat = 'mmm-dd, yyyy'
            Empty = False
            ForcePlusSign = False
            FrameStyle = fsLowered
            LabelWidth = 61
            LeftSpace = 66
            LeftText = 'Angle Z:'
            LeftTextAlignment = taRightJustify
            OverflowIndicator = '*********'
            ParentShowHint = False
            Precision = 2
            RightTextAlignment = taLeftJustify
            ShowHint = True
            StateText = 'undefined'
            Transparent = False
            Value = 160.000000000000000000
          end
          object NLabX: TNumLab
            Left = 8
            Top = 72
            Width = 133
            Height = 22
            Alignment = taCenter
            ColorLabBakG = clSilver
            ColorLabText = clBlack
            ColorOutBakG = clBtnFace
            ColorOutText = clBlack
            ColorScheme = csBWG
            Comma = False
            DisplayType = dtFixP
            DTFormat = 'mmm-dd, yyyy'
            Empty = False
            ForcePlusSign = False
            FrameStyle = fsLowered
            LabelWidth = 61
            LeftSpace = 66
            LeftText = 'Angle X:'
            LeftTextAlignment = taRightJustify
            OverflowIndicator = '*********'
            ParentShowHint = False
            Precision = 2
            RightTextAlignment = taLeftJustify
            ShowHint = True
            StateText = 'undefined'
            Transparent = False
            Value = 75.000000000000000000
          end
          object Label2: TLabel
            Left = 8
            Top = 296
            Width = 109
            Height = 16
            AutoSize = False
            Caption = 'Color of Mesh'
          end
          object NLabMag: TNumLab
            Left = 7
            Top = 149
            Width = 133
            Height = 22
            Alignment = taCenter
            ColorLabBakG = clSilver
            ColorLabText = clBlack
            ColorOutBakG = clBtnFace
            ColorOutText = clBlack
            ColorScheme = csBWG
            Comma = False
            DisplayType = dtFixP
            DTFormat = 'mmm-dd, yyyy'
            Empty = False
            ForcePlusSign = False
            FrameStyle = fsLowered
            LabelWidth = 61
            LeftSpace = 66
            LeftText = 'Size'
            LeftTextAlignment = taRightJustify
            OverflowIndicator = '*********'
            Precision = 3
            RightTextAlignment = taLeftJustify
            StateText = 'undefined'
            Transparent = False
            Value = 1.000000000000000000
          end
          object SBReset: TSpeedButton
            Left = 8
            Top = 448
            Width = 129
            Height = 31
            Anchors = [akLeft, akBottom]
            Caption = 'Default Setup'
            OnClick = SBResetClick
          end
          object NLabZScale: TNumLab
            Left = 7
            Top = 221
            Width = 133
            Height = 22
            Alignment = taCenter
            ColorLabBakG = clSilver
            ColorLabText = clBlack
            ColorOutBakG = clBtnFace
            ColorOutText = clBlack
            ColorScheme = csBWG
            Comma = False
            DisplayType = dtFixP
            DTFormat = 'mmm-dd, yyyy'
            Empty = False
            ForcePlusSign = False
            FrameStyle = fsLowered
            LabelWidth = 61
            LeftSpace = 66
            LeftText = 'Z Scale'
            LeftTextAlignment = taRightJustify
            OverflowIndicator = '*********'
            Precision = 3
            RightTextAlignment = taLeftJustify
            StateText = 'undefined'
            Transparent = False
            Value = 0.400000000000000000
          end
          object ScrBarAngleZ: TScrollBar
            Left = 8
            Top = 34
            Width = 129
            Height = 20
            Max = 360
            PageSize = 0
            Position = 160
            TabOrder = 0
            OnChange = ScrBarAngleZChange
          end
          object ScrBarAngleX: TScrollBar
            Left = 8
            Top = 98
            Width = 129
            Height = 20
            Max = 90
            PageSize = 0
            Position = 75
            TabOrder = 1
            OnChange = ScrBarAngleXChange
          end
          object CSelGrid: TColSel
            Left = 8
            Top = 313
            Width = 129
            Height = 22
            ColorBarWidth = 30
            Enabled = True
            NumColors = 20
            ParentShowHint = False
            SelColor = clBlack
            ShowHint = True
            TabOrder = 2
            OnChange = CSelGridChange
          end
          object ScrBarMagnif: TScrollBar
            Left = 8
            Top = 175
            Width = 129
            Height = 20
            Max = 200
            PageSize = 0
            Position = 100
            TabOrder = 3
            OnChange = ScrBarMagnifChange
          end
          object CBoxMesh: TCheckBox
            Left = 12
            Top = 336
            Width = 109
            Height = 17
            Caption = 'Visible Mesh'
            Checked = True
            State = cbChecked
            TabOrder = 4
            OnClick = CBoxMeshClick
          end
          object ScrBarSclZ: TScrollBar
            Left = 8
            Top = 247
            Width = 129
            Height = 20
            Min = 10
            PageSize = 0
            Position = 40
            TabOrder = 5
            OnChange = ScrBarSclZChange
          end
        end
      end
    end
    object Panel7: TPanel
      Left = 0
      Top = 461
      Width = 676
      Height = 75
      Align = alBottom
      TabOrder = 1
      object RCColCode: TRChart
        Left = 1
        Top = -6
        Width = 674
        Height = 80
        Align = alBottom
        AllocSize = 1000
        AutoRedraw = True
        MarginRight = 14
        MarginTop = 20
        MarginBottom = 40
        RRim = 14
        TRim = 20
        BRim = 40
        BackGroundImg.IncludePath = False
        BackGroundImg.FillMode = bfStretch
        BackGroundImg.AreaMode = bamNone
        BackGroundImg.AreaColor = 14540253
        BackGroundImg.AreaLeft = -1.000000000000000000
        BackGroundImg.AreaRight = 1.000000000000000000
        BackGroundImg.AreaTop = 1.000000000000000000
        BackGroundImg.AreaBottom = -1.000000000000000000
        ClassDefault = 0
        GridStyle = gsNone
        Isometric = False
        JointLayers.L01xControlledBy = 1
        JointLayers.L01yControlledBy = 1
        JointLayers.L02xControlledBy = 2
        JointLayers.L02yControlledBy = 2
        CaptionPosX = 0
        CaptionPosY = -16
        CaptionAlignment = taRightJustify
        CaptionAnchorHoriz = cahChartRight
        CaptionAnchorVert = cavChartTop
        CrossHair1.Color = clBlack
        CrossHair1.Layer = 1
        CrossHair1.Mode = chOff
        CrossHair1.LineType = psSolid
        CrossHair1.LineWid = 1
        CrossHair2.Color = clBlack
        CrossHair2.Layer = 2
        CrossHair2.Mode = chOff
        CrossHair2.LineType = psSolid
        CrossHair2.LineWid = 1
        CrossHair3.Color = clBlack
        CrossHair3.Layer = 2
        CrossHair3.Mode = chOff
        CrossHair3.LineType = psSolid
        CrossHair3.LineWid = 1
        CrossHair4.Color = clBlack
        CrossHair4.Layer = 2
        CrossHair4.Mode = chOff
        CrossHair4.LineType = psSolid
        CrossHair4.LineWid = 1
        MouseAction = maNone
        MouseCursorFixed = False
        Scale1X.CaptionPosX = 0
        Scale1X.CaptionPosY = 22
        Scale1X.CaptionAlignment = taCenter
        Scale1X.CaptionAnchor = uaSclCenter
        Scale1X.ColorScale = clBlack
        Scale1X.DateFormat.TimeFormat = tfHHMMSS
        Scale1X.DateFormat.DateSeparator = '-'
        Scale1X.DateFormat.TimeSeparator = ':'
        Scale1X.DateFormat.YearLength = ylYYYY
        Scale1X.DateFormat.MonthName = True
        Scale1X.DateFormat.DateOrder = doDDMMYY
        Scale1X.DateFormat.DateForTime = dtOnePerDay
        Scale1X.DecPlaces = -2
        Scale1X.Font.Charset = DEFAULT_CHARSET
        Scale1X.Font.Color = clWindowText
        Scale1X.Font.Height = -13
        Scale1X.Font.Name = 'MS Sans Serif'
        Scale1X.Font.Style = []
        Scale1X.Logarithmic = False
        Scale1X.LabelType = ftNum
        Scale1X.MinTicks = 3
        Scale1X.MinRange = 0.000000000100000000
        Scale1X.RangeHigh = 1.000000000000000000
        Scale1X.ShortTicks = True
        Scale1X.ScalePos = 0
        Scale1X.Visible = True
        Scale1X.ScaleLocation = slBottom
        Scale1Y.CaptionPosX = 0
        Scale1Y.CaptionPosY = -16
        Scale1Y.CaptionAlignment = taLeftJustify
        Scale1Y.CaptionAnchor = uaSclTopLft
        Scale1Y.ColorScale = clBlack
        Scale1Y.DateFormat.TimeFormat = tfHHMMSS
        Scale1Y.DateFormat.DateSeparator = '-'
        Scale1Y.DateFormat.TimeSeparator = ':'
        Scale1Y.DateFormat.YearLength = ylYYYY
        Scale1Y.DateFormat.MonthName = True
        Scale1Y.DateFormat.DateOrder = doDDMMYY
        Scale1Y.DateFormat.DateForTime = dtOnePerDay
        Scale1Y.DecPlaces = -2
        Scale1Y.Font.Charset = DEFAULT_CHARSET
        Scale1Y.Font.Color = clWindowText
        Scale1Y.Font.Height = -13
        Scale1Y.Font.Name = 'MS Sans Serif'
        Scale1Y.Font.Style = []
        Scale1Y.Logarithmic = False
        Scale1Y.LabelType = ftNum
        Scale1Y.MinTicks = 3
        Scale1Y.MinRange = 0.000000000100000000
        Scale1Y.RangeHigh = 1.000000000000000000
        Scale1Y.ShortTicks = True
        Scale1Y.ScalePos = 0
        Scale1Y.Visible = False
        Scale1Y.ScaleLocation = slLeft
        Scale2X.CaptionPosX = 10
        Scale2X.CaptionPosY = 100
        Scale2X.CaptionAlignment = taCenter
        Scale2X.CaptionAnchor = uaSclCenter
        Scale2X.ColorScale = clMaroon
        Scale2X.DateFormat.TimeFormat = tfHHMMSS
        Scale2X.DateFormat.DateSeparator = '-'
        Scale2X.DateFormat.TimeSeparator = ':'
        Scale2X.DateFormat.YearLength = ylYYYY
        Scale2X.DateFormat.MonthName = True
        Scale2X.DateFormat.DateOrder = doDDMMYY
        Scale2X.DateFormat.DateForTime = dtOnePerDay
        Scale2X.DecPlaces = -2
        Scale2X.Font.Charset = DEFAULT_CHARSET
        Scale2X.Font.Color = clWindowText
        Scale2X.Font.Height = -13
        Scale2X.Font.Name = 'MS Sans Serif'
        Scale2X.Font.Style = []
        Scale2X.Logarithmic = False
        Scale2X.LabelType = ftNum
        Scale2X.MinTicks = 3
        Scale2X.MinRange = 0.000000000100000000
        Scale2X.RangeHigh = 1.000000000000000000
        Scale2X.ShortTicks = True
        Scale2X.ScalePos = 0
        Scale2X.Visible = False
        Scale2X.ScaleLocation = slBottom
        Scale2Y.CaptionPosX = 10
        Scale2Y.CaptionPosY = 100
        Scale2Y.CaptionAlignment = taRightJustify
        Scale2Y.CaptionAnchor = uaSclTopLft
        Scale2Y.ColorScale = clMaroon
        Scale2Y.DateFormat.TimeFormat = tfHHMMSS
        Scale2Y.DateFormat.DateSeparator = '-'
        Scale2Y.DateFormat.TimeSeparator = ':'
        Scale2Y.DateFormat.YearLength = ylYYYY
        Scale2Y.DateFormat.MonthName = True
        Scale2Y.DateFormat.DateOrder = doDDMMYY
        Scale2Y.DateFormat.DateForTime = dtOnePerDay
        Scale2Y.DecPlaces = -2
        Scale2Y.Font.Charset = DEFAULT_CHARSET
        Scale2Y.Font.Color = clWindowText
        Scale2Y.Font.Height = -13
        Scale2Y.Font.Name = 'MS Sans Serif'
        Scale2Y.Font.Style = []
        Scale2Y.Logarithmic = False
        Scale2Y.LabelType = ftNum
        Scale2Y.MinTicks = 3
        Scale2Y.MinRange = 0.000000000100000000
        Scale2Y.RangeHigh = 1.000000000000000000
        Scale2Y.ShortTicks = True
        Scale2Y.ScalePos = 0
        Scale2Y.Visible = False
        Scale2Y.ScaleLocation = slLeft
        ShadowStyle = ssFlying
        ShadowColor = clGrayText
        ShadowBakColor = clBtnFace
        TextFontStyle = []
        TextBkStyle = tbClear
        TextBkColor = clWhite
        TextAlignment = taCenter
      end
    end
  end
  object ColorDialog1: TColorDialog
    Left = 232
    Top = 120
  end
  object popMenPlot3D: TPopupMenu
    Left = 200
    Top = 120
    object Rotate1: TMenuItem
      Caption = 'Rotate'
      OnClick = Rotate1Click
    end
    object Pan1: TMenuItem
      Caption = 'Pan'
      OnClick = Pan1Click
    end
    object Zoom1: TMenuItem
      Caption = 'Zoom'
      OnClick = Zoom1Click
    end
    object RotateandZoom1: TMenuItem
      Caption = 'Rotate and Zoom'
      OnClick = RotateandZoom1Click
    end
    object RotXOnly1: TMenuItem
      Caption = 'Rot X Only'
      OnClick = RotXOnly1Click
    end
    object RotZOnly1: TMenuItem
      Caption = 'Rot Z Only'
      OnClick = RotZOnly1Click
    end
  end
  object ODiag: TOpenDialog
    Left = 264
    Top = 120
  end
  object PopMenEmptyDummy: TPopupMenu
    Left = 200
    Top = 152
  end
end
